#!/bin/bash
#shellcheck source=/dev/null

###################################################
#  Install Script for automaticall add's plugins        
#  @Zahrajsi.net
#  @Owner: F0cus
#  Version: 1.2
###################################################
clear

# Check Distro
    check_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$(echo "$ID" | awk '{print tolower($0)}')
        OS_VER=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si | awk '{print tolower($0)}')
        OS_VER=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$(echo "$DISTRIB_ID" | awk '{print tolower($0)}')
        OS_VER=$DISTRIB_RELEASE
    elif [ -f /etc/debian_version ]; then
        OS="debian"
        OS_VER=$(cat /etc/debian_version)
    elif [ -f /etc/SuSe-release ]; then
        OS="SuSE"
        OS_VER="?"
    elif [ -f /etc/redhat-release ]; then
        OS="Red Hat/CentOS"
        OS_VER="?"
    else
        OS=$(uname -s)
        OS_VER=$(uname -r)
    fi

    OS=$(echo "$OS" | awk '{print tolower($0)}')
    OS_VER_MAJOR=$(echo "$OS_VER" | cut -d. -f1)
    }
#

#color configuration!
    colour(){
        GREEN="\e[0;92m"
        YELLOW="\033[1;33m"
        BLUE='\033[0;36m'
        reset="\e[0m"
    }

    print_brake() {
    for ((n = 0; n < $1; n++)); do
        echo -n "#"
    done
    echo ""
    }

    print_warning() {
    COLOR_YELLOW='\033[1;33m'
    COLOR_NC='\033[0m'
    echo -e "* ${COLOR_YELLOW}WARNING${COLOR_NC}: $1"
    }

    print_success() {
    COLOR_GREEN='\033[0;32m'
    COLOR_NC='\033[0m'
    echo -e "* ${COLOR_GREEN}SUCCESS${COLOR_NC}: $1"
    echo ""
    }

    print_info() {
    COLOR_BLUE='\033[0;36m'
    COLOR_NC='\033[0m'
    echo -e "* ${COLOR_BLUE}INFO${COLOR_NC}: $1"
    }

    print_error() {
    COLOR_RED='\033[0;31m'
    COLOR_NC='\033[0m'
    echo -e "* ${COLOR_RED}INFO${COLOR_NC}: $1"
    }

    low_echo() {
    echo -e "${YELLOW} * ${reset}: $1"
    }
#

# Variables
    Variables(){
        SCRIPT_VERSION="2.2"
        SUPPORT_LINK="https://zahrajsi.net"
        SPIGOT_VER="1.18.1"
        WATERFALL_VER="1.18.1"
        SPIGOT_LINK="https://papermc.io/ci/job/$SPIGOT_VER/lastStableBuild/artifact/paperclip.jar"
        WATERFALL_LINK="https://papermc.io/ci/job/$WATERFALL_VER/lastStableBuild/artifact/waterfall.jar"
        SPIGOT_FILE="server.jar"
        WATERFALL_FILE="waterfall.jar"
        BUKKIT_FILE="bukkit.jar"
        ERRORS=()
        DEBUG="NO"
    }
#

# Find Instance
    find_instance() {
    set -e
    echo
    print_brake 47
    echo -e "* ${BLUE}Looking for your server instance...${reset}"
    print_brake 47
    echo
    
    sleep 3
    if [ -f "$SPIGOT_FILE" ]; then
        echo
        INSTANCE="SPIGOT"

    elif [ -f "$WATERFALL_FILE" ]; then
        echo
        INSTANCE="WATERFALL"

    elif [ -f "$BUKKIT_FILE" ]; then
        echo
        INSTANCE="BUKKIT" 

    else
        INSTANCE="NON_SUPPORTED_INSTANCE"
    fi
    }
#


#Initial's of backup
    backup() {
        echo ""
        print_brake 47
        echo -e "* ${GREEN}Performing security backup for your Instance...${reset}"
        print_brake 47

        if [ -f "backup" ]; then
            echo
            print_brake 45
            echo -e "* ${GREEN}There is already a backup, skipping step...${reset}"  
            print_brake 45
            sleep 6
            echo
        else
            print_brake 47
            print_info "Making new BackUp"
            print_brake 47
            sleep 2
            tar -czvf "backup" -- *
            sleep 6
        fi
}
#



# VAR SPIGOT
    vars_spigot(){
    PROPERTIES="server.properties" 
    D_FILE="motd_spigot" 
    ICON="server-icon.png" 
    Login_D="plugins/AuthMe"
    Login_tar="authme-conf.tar.gz"
    S_DIR="plugins"
    }
#

# VAR WATERAFLL
    vars_waterfall(){
    W_PROPERTIES="config.yml" 
    W_D_FILE="motd_watefall" 
    ICON="server-icon.png" 
    W_Login_D="plugins/AuthMeBungee"
    W_Login_tar="authme-conf-bungee.tar.gz"
    W_S_DIR="plugins"
    }
#

# Initial code
    main() {
    # WELCOME MESS.
    # RUN_CODE
        RUN_CODE(){
            check_distro
            Variables
            colour

            errors(){
                for t in "${error[@]}"; do
                    echo "$t"
                done
            }
        }  
    #
    RUN_CODE
    print_brake 47
    echo -e "* ${YELLOW} Install Script AutoConfigNODE ${reset}"
    low_echo "Owner: F0cus"
    low_echo "Version: $SCRIPT_VERSION"
    low_echo "Support: $SUPPORT_LINK"
    print_brake 47
    echo -e "* ${YELLOW} Checking Download URL ${reset}"
    if wget --spider "https://zahrajsi.net/amp/assets/pngs/server-icon.png" 2>/dev/null; then
        SERVER_LINK="YES"
    else
        SERVER_LINK="NO"
    fi
    backup
    find_instance
#

# VAR OTHER PLUGINS
    # MYCOMMAND
        pl_mycommand(){
        MYCOMMAND_D="plugins/MyCommand"
        MYCOMMAND_link="https://zahrajsi.net/amp/assets/installer/MyCommand.jar"
        MYCOMMAND_F="MyCommand.jar"
        }
    #
    # Skript
        pl_skript(){
        Skript_D="plugins/Skript"
        Skript_link="https://zahrajsi.net/amp/assets/installer/Skript.jar"
        Skript_F="Skript.jar"
        }
    #
    # Residence
        pl_residence(){
        RESIDENCE_D="plugins/Residence"
        RESIDENCE_link="https://zahrajsi.net/amp/assets/installer/Residence.jar"
        RESIDENCE_F="Residence.jar"
        }
    #
#

# Initial Another PLugins
    # Install MyCommand
        mycommand(){
            pl_mycommand
            if [ -d "$MYCOMMAND_D" ] && [ ! "$MYCOMMAND" == "TRUE" ]; then
                print_info "> MyCommand plugin is already installed.."
            else
                print_info "> Installing MyCommand"
                if [ ! -f "$MYCOMMAND_F" ]; then
                    low_echo "The $MYCOMMAND_F file does not exist, they are downloading and extracting"
                    if [ ! -d "$MYCOMMAND_D" ]; then
                        mkdir "$MYCOMMAND_D"
                        low_echo "Making folder!"
                    fi
                wget -q "$MYCOMMAND_link"
                low_echo "Move $MYCOMMAND_F"
                sleep 2
                mv "$MYCOMMAND_F" plugins
                print_success "> MyCommand set successfully!"
                MYCOMMAND="TRUE"
                fi
            fi
        }
    #

    # Install Skript
        skript(){
            pl_skript
            if [ -d "$Skript_D" ] && [ ! "$SKRIPT" == "TRUE" ]; then
                print_info "> Skript plugin is already installed.."
            else
                print_info "> Installing Skript"
                if [ ! -f "$Skript_F" ]; then
                    low_echo "The $Skript_F file does not exist, they are downloading and extracting"
                    if [ ! -d "$Skript_D" ]; then
                        mkdir "$Skript_D"
                        low_echo "Making folder!"
                    fi
                wget -q "$Skript_link"
                low_echo "Move $Skript_F"
                sleep 2
                mv "$Skript_F" plugins
                print_success "> Skript set successfully!"
                SKRIPT="TRUE"
                fi
            fi
        }
    #

    # Install Residence
        residence(){
            pl_residence
            if [ -d "$RESIDENCE_D" ] && [ ! "$RESIDENCE" == "TRUE" ]; then
                print_info "> Residence plugin is already installed.."
            else
                print_info "> Installing Residence"
                if [ ! -f "$RESIDENCE_F" ]; then
                    low_echo "The $RESIDENCE_F file does not exist, they are downloading and extracting"
                    if [ ! -d "$RESIDENCE_D" ]; then
                        mkdir "$RESIDENCE_D"
                        low_echo "Making folder!"
                    fi
                wget -q "$RESIDENCE_link"
                low_echo "Move $RESIDENCE_F"
                sleep 2
                mv "$RESIDENCE_F" plugins
                print_success "> Residence set successfully!"
                RESIDENCE="TRUE"
                fi
            fi
        }
    #
#




    # SPIGOT INSTANCE
        if [ "$SERVER_LINK" == "YES" ]; then
            install_spigot(){
                if [ "$INSTANCE" == "SPIGOT" ]; then
                    vars_spigot
                    print_info "A spigot was detected!"
                    echo -e " ${BLUE}* ${reset}A spigot was detected!"
                    echo ""
                    low_echo "1. MOTD"
                    low_echo "2. Server-Icon"
                    low_echo "3. Login Plugin (AuthMe)"
                    low_echo "4. Another Plugins (INSTALLER)"
                    echo -e ""
                    print_info "> Inialize installer for spigot"

                    # Install MOTD
                    touch "$PROPERTIES" #Make sure file exist
                    if [ -f "$PROPERTIES" ]; then
                        #Check for Motd
                        if grep -q Minecraft "$PROPERTIES"; then
                            TMP_GREP="UNSET"
                        elif grep -q ZAHRAJSI "$PROPERTIES"; then
                            TMP_GREP="SET"
                        else
                            TMP_GREP="USER"
                        fi
                    fi
                    if [ "$TMP_GREP" == "USER" ]; then
                        print_info "> MOTD is already set, by the previous user!"
                    elif [ "$TMP_GREP" == "SET" ]; then
                        print_info "> MOTD already set! Skipping.."
                    elif [ "$TMP_GREP" == "UNSET" ]; then
                        print_warning "> Creating the necessary files.. for $INSTANCE"
                        touch "$PROPERTIES"
                        print_warning "> Downloading MOTD from an external server.. for $INSTANCE"
                        if [ ! -f "$D_FILE" ]; then
                            wget -q "https://zahrajsi.net/amp/assets/installer/motd_spigot"
                            cat "$D_FILE" > "$PROPERTIES"
                            print_success "> MOTD set successfully!"
                            MOTD_SET="true"
                            rm -r "$D_FILE"
                        fi
                    fi

                    # Install Server-Icon
                    if [ -f "$ICON" ]; then
                        print_info "> The $ICON icon has already been set!"
                    else
                        print_info "> Set Icon"
                        wget -q "https://zahrajsi.net/amp/assets/pngs/server-icon.png"
                        low_echo "> Downloading Server Icon from an external server.. for $INSTANCE"
                        print_success "> Icon set successfully!"
                    fi

                    # Install Login Plugin
                    if [ -d "$Login_D" ] && [ ! "$AUTHME" == "TRUE" ]; then
                        print_info "> Authme plugin is already installed.."
                    else
                        print_info "> Installing AuthMe"
                        if [ ! -f "$Login_tar" ]; then
                            low_echo "The $Login_tar file does not exist, they are downloading and unpacking"
                            if [ ! -f "$S_DIR" ]; then
                                mkdir "$S_DIR"
                                low_echo "Making folder!"
                            fi
                        wget -q "https://zahrajsi.net/amp/assets/installer/authme-conf.tar.gz"
                        low_echo "Unzipping the authme-conf.tar.gz"
                        sleep 2
                        tar -zxf authme-conf.tar.gz --directory plugins
                        rm -r authme-conf.tar.gz
                        print_success "> AuthMe set successfully!"
                        AUTHME="TRUE"
                        fi
                    fi

                    # Install Another Plugin
                    if [ "$A_PLUGIN" != "TRUE" ]; then
                        echo -e ""
                        print_brake 45
                        print_warning "Installing Other Plugins"
                        print_brake 45
                        echo -e ""
                        mycommand
                        skript
                        residence
                    fi
                fi 
            }
            install_spigot
            # END OF SPIGOT 

             install_waterfall(){
                if [ "$INSTANCE" == "WATERFALL" ]; then
                    vars_waterfall
                    print_info "A waterfall was detected!"
                    echo -e " ${BLUE}* ${reset}A waterfall was detected!"
                    echo ""
                    low_echo "1. MOTD"
                    low_echo "2. Server-Icon"
                    low_echo "3. Login Plugin (AuthMeBungee)"
                    echo -e ""
                    print_info "> Inialize installer for waterafll"

                    # Install MOTD
                    touch "$W_PROPERTIES" #Make sure file exist
                    if [ -f "$W_PROPERTIES" ]; then
                        #Check for Motd
                        if grep -q Minecraft "$W_PROPERTIES"; then
                            TMP_GREP="UNSET"
                        elif grep -q ZAHRAJSI "$W_PROPERTIES"; then
                            TMP_GREP="SET"
                        else
                            TMP_GREP="USER"
                        fi
                    fi
                    if [ "$TMP_GREP" == "USER" ]; then
                        print_info "> MOTD is already set, by the previous user!"
                    elif [ "$TMP_GREP" == "SET" ]; then
                        print_info "> MOTD already set! Skipping.."
                    elif [ "$TMP_GREP" == "UNSET" ]; then
                        print_warning "> Creating the necessary files.. for $INSTANCE"
                        touch "$W_PROPERTIES"
                        print_warning "> Downloading MOTD from an external server.. for $INSTANCE"
                        if [ ! -f "$W_D_FILE" ]; then
                            wget -q "https://zahrajsi.net/amp/assets/installer/$W_D_FILE"
                            cat "$D_FILE" > "$W_PROPERTIES"
                            print_success "> MOTD set successfully!"
                            MOTD_SET="true"
                            rm -r "$W_D_FILE"
                        fi
                    fi

                    # Install Server-Icon
                    if [ -f "$ICON" ]; then
                        echo -e ""
                        print_info "> The $ICON icon has already been set!"
                    else
                        echo -e ""
                        print_info "> Set Icon"
                        wget -q "https://zahrajsi.net/amp/assets/pngs/server-icon.png"
                        low_echo "> Downloading Server Icon from an external server.. for $INSTANCE"
                        print_success "> Icon set successfully!"
                    fi

                    # Install Login Plugin
                    if [ -d "$W_Login_D" ] && [ ! "$AUTHMEBUNGEE" == "TRUE" ]; then
                        print_info "> Authme plugin is already installed.."
                    else
                        print_info "> Installing AuthMeBungee"
                        if [ ! -f "$W_Login_tar" ]; then
                            low_echo "The $Login_tar file does not exist, they are downloading and unpacking"
                            if [ ! -f "$W_S_DIR" ]; then
                                mkdir "$W_S_DIR"
                                low_echo "Making folder!"
                            fi
                        wget -q "https://zahrajsi.net/amp/assets/installer/$W_Login_tar"
                        low_echo "Unzipping the $W_Login_tar"
                        sleep 2
                        tar -zxf "$W_Login_tar" --directory plugins
                        rm -r "$W_Login_tar"
                        print_success "> AuthMeBungee set successfully!"
                        AUTHMEBUNGEE="TRUE"
                        fi
                    fi
                fi 
            }
            install_waterfall
            # END OF WATERFALL 

            if [ "$INSTANCE" == "NON_SUPPORTED_INSTANCE" ]; then
                print_error "We couldn't find any installation, do you want to install a new instance?"
                echo -e ""
                PS3='Vyber možnost:  '
                options=("Paper-Spigot" "Waterfall" "Ukončit")
                select opt in "${options[@]}"
                do
                    case $opt in
                        "Paper-Spigot")
                            set -e
                            echo ""
                            low_echo "Downloading Spigot $SPIGOT_VER".
                            wget -q "$SPIGOT_LINK" -O "$SPIGOT_FILE"
                            find_instance
                            install_spigot
                            break 1
                            ;;
                        "Waterfall")
                            set -e
                            low_echo "Downloading Waterfall $WATERFALL_VER".
                            wget -q "$WATERFALL_LINK" -O "$WATERFALL_FILE"
                            find_instance
                            install_waterfall
                            break 1
                            ;;
                        "Ukončit")
                            break
                            ;;
                        *) echo "invalid option $REPLY";;
                    esac
                done
            fi
        #
        else
            print_error "Webpage for download dependents in unavailable"
        fi # END URL LINK

    #    
    }
#
main
if [ "$DEBUG" == "YES" ]; then
    debug(){
        echo -e ""
        print_error "DEBUG MENU"
        echo -e ""
        echo "$SERVER_LINK"
        echo "$PROPERTIES"
        echo "$INSTANCE"
        echo "$MOTD_SET"
        echo "$TMP_GREP"
        echo "$AUTHME"
        errors
    }
    debug
fi
