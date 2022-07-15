#   ______                   
#  /_  __/__  ____ ___  ____ 
#   / / / _ \/ __ `__ \/ __ \
#  / / /  __/ / / / / / /_/ /
# /_/  \___/_/ /_/ /_/ .___/ 
#                   /_/

# -----------------------------------------------------------------
# Functions for Testing my ICS Final Project
# -----------------------------------------------------------------
function ups() {
    VAR="/home/larrylime/Programming/ics_project/chat_server.py"
    powershell.exe -c "python3 $VAR"
}

function upc() {
    VAR="/home/larrylime/Programming/ics_project/chat_cmdl_client.py" 
    powershell.exe -c "python3 $VAR"
}

function ngstart() {
    powershell.exe -c "ngrok tcp --region jp $1"
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

function cvim() {
    cd ~/.config
    mv nvim temp; mv nvim_alt nvim; mv temp nvim_alt
}

function tj ()
{
  cd /home/larrylime/Programming/trydjango/src/trydjango/
}

function senv ()
{
  source /home/larrylime/Programming/trydjango/bin/activate

}
