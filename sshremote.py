import sys # modul sys untuk argumen 
import paramiko # modul paramiko untuk remote command

error = sys.argv[0] # command.py atau index ke 0
def print_error():  # function untuk print error 
    sys.exit(f'How to use : python {error} command_playbooks filehost')

def main(argv):  # function utama
    if not len(argv) == 3: # keadaan dimana jika panjang index tidak sama dengan 2 akan memanggil func print error
        print_error() 
    command = str(sys.argv[1]) # variabel untuk memanggil argumen index ke-1 atau command 
    file = str(sys.argv[2])
    command_ssh = str(sys.argv[3])
    print(command) # variabel untuk memanggil argumen index ke-2 atau filehost
    
    host = open(file, 'r') # variable untuk memanggil atau membuka filehost agar dapat dimasukan kedalam variabel
    for host_conn in host: # perulangan untuk iterasi file_host
        print("Connected To " + host_conn)

    command_playbooks = open(command, 'r')
    for cmd in command_playbooks:
        print(cmd)  

    command_mikrotik = open(command_ssh, 'r')
    for cmd_mikrotik in command_mikrotik:
        print(cmd_mikrotik) 

    client = paramiko.SSHClient() # function untuk melakukan koneksi ke client
    client.load_system_host_keys() # function untuk load host key
    client.set_missing_host_key_policy(paramiko.WarningPolicy()) # function untuk jika host key tidak ada 
    client.connect(host_conn, username='test123', password='test123') # funtion yang mendeklarasikan credential untuk koneksi ke remote server
    stdin, stdout, stderr = client.exec_command(cmd) # function untuk memasukan perintah yang akan di eksekusi di remote server
    stdin = client.exec_command(cmd_mikrotik)
    for line in stdout:
        print(f'result => {line.strip()}\n') # perulangan untuk print atau stdout dari hasil remote

if __name__ == '__main__':
    main(sys.argv[1::])
