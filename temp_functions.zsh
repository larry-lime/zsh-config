function ups()
{
    cd /mnt/c/Users/larry/nyu/ics/final_project
    VAR=chat_server.py
    powershell.exe -c "python3 $VAR"
    #python3 chat_server.py
}

function upc()
{
    cd /mnt/c/Users/larry/nyu/ics/final_project 
    VAR=chat_cmdl_client.py
    powershell.exe -c "python3 $VAR"
    #python3 chat_cmdl_client.py
    #pwsh.exe python3 chat_cmdl_client.py
}

function fin_start()
{
    cd /mnt/c/Users/larry/fin_analysis/python_fin_analysis 
    VAR=fin_start.py
    python3 "fin_start.py"
    #powershell.exe -c "python3 $VAR"
    #python3 chat_cmdl_client.py
    #pwsh.exe python3 chat_cmdl_client.py
}


