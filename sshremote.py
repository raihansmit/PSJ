import sys # modul sys untuk argumen 
import paramiko # modul paramiko untuk remote command
import time # modul time untuk waktu
import socket # modul socket untuk cek port ssh


error = sys.argv[0] # command.py atau index ke 0
def print_error():  # function untuk print error 
    sys.exit(f'How to use : python {error} command_playbooks filehost')

def main(argv):  # function utama
    if not len(argv) == 6: # keadaan dimana jika panjang index tidak sama dengan 2 akan memanggil func print error
        print_error() 
    command = str(sys.argv[1]) # variabel untuk memanggil argumen index ke-1 atau command 
    file = str(sys.argv[2])
    command_ssh = str(sys.argv[3])
    port_number = str(sys.argv[4])
    uname = str(sys.argv[5])
    pwd = str(sys.argv[6])
    print(command) # variabel untuk memanggil argumen index ke-2 atau filehost
    
    history_port = open('file_log_number.log', 'r')
    history_port.readline()[-1]
    for x in history_port:
        port_history = int(x.strip())

    host = open(file, 'r') # variable untuk memanggil atau membuka filehost agar dapat dimasukan kedalam variabel
    for host_conn in host: # perulangan untuk iterasi file_host
        print("Connected To " + host_conn)
    host_conn = host_conn.rstrip()

    command_playbooks = open(command, 'r')
    for cmd in command_playbooks:
        print(cmd)  

    command_device = open(command_ssh, 'r')
    for cmd_device in command_device:
        print(cmd_device) 
    
    local_time = time.time()
    file_log_number = open('file_log_number.log', 'a')
    file_log_number.writelines(f'{port_number} \n')
    file_log_number.close()

    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex((host_conn,22))
    if result == 0:
        print ("Port is open")
        port_number = 22
    else:
        print ("Port is not open")
        port_number = port_history
    sock.close()
    
    client = paramiko.SSHClient() # function untuk melakukan koneksi ke client
    client.load_system_host_keys() # function untuk load host key
    client.set_missing_host_key_policy(paramiko.WarningPolicy()) # function untuk jika host key tidak ada 
    client.connect(host_conn, username=uname, password=pwd, port=port_number, look_for_keys=False) # funtion yang mendeklarasikan credential untuk koneksi ke remote server
    stdin, stdout, stderr = client.exec_command(cmd) # function untuk memasukan perintah yang akan di eksekusi di remote server
    stdin = client.exec_command(cmd_device)
    for line in stdout:
        print(f'result => {local_time}{line.strip()}\n') # perulangan untuk print atau stdout dari hasil remote

if __name__ == '__main__':
    main(sys.argv[1::])
