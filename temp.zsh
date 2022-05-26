#████████╗███████╗███╗░░░███╗██████╗░
#╚══██╔══╝██╔════╝████╗░████║██╔══██╗
#░░░██║░░░█████╗░░██╔████╔██║██████╔╝
#░░░██║░░░██╔══╝░░██║╚██╔╝██║██╔═══╝░
#░░░██║░░░███████╗██║░╚═╝░██║██║░░░░░
#░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝╚═╝░░░░░

# -----------------------------------------------------------------
# Functions for Testing my ICS Final Project
# -----------------------------------------------------------------
function ups() {
    cd /mnt/c/Users/larry/nyu/ics/final_project
    VAR=chat_server.py
    powershell.exe -c "python3 $VAR"
}

function upc() {
    cd /mnt/c/Users/larry/nyu/ics/final_project 
    VAR=chat_cmdl_client.py
    powershell.exe -c "python3 $VAR"
}

function fin_start() {
    cd /mnt/c/Users/larry/fin_analysis/python_fin_analysis 
    VAR=fin_start.py
    python3 "fin_start.py"
}

function chat_system() {
    cd /mnt/c/Users/larry/nyu/ics/final_project
}

function chat_client() {
    cd /mnt/c/Users/larry/nyu/ics/final_project
    nvim chat_client_class.py
}

