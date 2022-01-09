#!/bin/bash
#shellcheck source=/dev/null

###################################################
<<<<<<< Updated upstream
#  Install Script for automaticall add's plugins        
#  @Zahrajsi.net
#  @Owner: F0cus
#  Version: 3.1
=======
#  I#  Install Script for automaticall add's plugins        
#  @Zahrajsi.net
#  @Owner: F0cus
#  Version: 3.2
>>>>>>> Stashed changes
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
    apt install -y jq
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

    print_brake_A() {
    for ((n = 0; n < $1; n++)); do
        echo -n " ┅"
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

# Install Var
    install_var(){
        print_info "You can exclude from the backup files.."
        print_info "folders you don't want, your already excluded world is also logs.. "
        print_warning "Use a space between each exclusion , e.g. test.run.txt minecraft.jar ... etc"
        print_info "Your exceptions"
        read -p '>>> : ' I1 I2 I3 I4 I5 I6 I7 I8 I9 I10 
        print_info "Name of your world."
        read -p '>>> : ' world
        print_info "Set your verison"
        read -p '>>> : ' VERSION
        echo "$WATERFALL_VER"
        if [ -z "$world" ]; then
            world="world"
        fi
    }

# Variables
    Variables(){
        SCRIPT_VERSION="3.0"
        SUPPORT_LINK="https://zahrajsi.net"
        SUPPORT="https://zahrajsi.net"
        SCRIPT_N="AutoConfig-Node"
        BACKUP="backup"
        world="world"
        SPIGOT_FILE="server.jar"
        WATERFALL_FILE="waterfall.jar"
        BUKKIT_FILE="bukkit.jar"
        ERRORS=()
        DEBUG="NO"
    }
#

#Initial's of backup
    backup() {
        echo -e ""
        echo -e "* ${GREEN}Performing security $BACKUP for your Instance...${reset}"

        if [ -f "backup" ]; then
            echo
            echo -e "* ${GREEN}There is already a $BACKUP, skipping step...${reset}"  
            echo 
        else
            echo -e ""
            print_info "Creating a new $BACKUP, without the $IGNORE_BACKUP file"
            print_brake_A 40
            #tar -czvf "$BACKUP" --exclude="$IGNORE_BACKUP"
            tar -czvf "$BACKUP" --exclude="$world" --exclude="$world"_the_end --exclude="$world"_nether --exclude='*.bash' --exclude='LICENSE' --exclude='logs' --exclude="$I1" --exclude="$I2" --exclude="$I3" --exclude="$I4" --exclude="$I5" --exclude="$I6" --exclude="$I7" --exclude="$I8" --exclude="$I9" --exclude="$I10" *

        fi
}
#

# Find Instance
    find_instance() {
    set -e
    echo
    echo -e "* ${BLUE}Looking for your server instance...${reset}"
    print_brake_A 40
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

    spigot_wget(){
        if [ -z "$VERSION" ]; then
        # CHECK VERSION FOR SPIGOT
            sleep 2
            curl -s https://papermc.io/api/v2/projects/paper/ | jq '.' > tmp_ver.json
            cat tmp_ver.json | jq '.versions[]'  > spigot_ver.tmp
            sed 's/\"//g' spigot_ver.tmp > tmp
            SPIGOT_VER=$(tail -1 tmp)
            low_echo "Version = $SPIGOT_VER"
            rm -r tmp_ver.json
            rm -r spigot_ver.tmp
            rm -r tmp
            # CHECK BUILF FOR SPIGOT
            curl -s https://papermc.io/api/v2/projects/paper/versions/$SPIGOT_VER/ | jq '.' > tmp_build.json
            cat tmp_build.json | jq '.builds[]'  > spigot_ver.tmp
            sed 's/\"//g' spigot_ver.tmp > tmp
            SPIGOT_BUILD=$(tail -1 tmp)
            low_echo "Build = $SPIGOT_BUILD"
            sleep 4
            rm -r tmp_build.json
            rm -r spigot_ver.tmp
            rm -r tmp
            #Download and checksum
            wget -q -O server.jar https://papermc.io/api/v2/projects/paper/versions/$SPIGOT_VER/builds/$SPIGOT_BUILD/downloads/paper-$SPIGOT_VER-$SPIGOT_BUILD.jar
        else
            # CHECK BUILF FOR SPIGOT
            curl -s https://papermc.io/api/v2/projects/paper/versions/$VERSION/ | jq '.' > tmp_build.json
            cat tmp_build.json | jq '.builds[]'  > spigot_ver.tmp
            sed 's/\"//g' spigot_ver.tmp > tmp
            SPIGOT_BUILD=$(tail -1 tmp)
            low_echo "Version = $VERSION"
            low_echo "Build = $SPIGOT_BUILD"
            sleep 4
            rm -r tmp_build.json
            rm -r spigot_ver.tmp
            rm -r tmp
            #Download and checksum
            wget -q -O server.jar https://papermc.io/api/v2/projects/paper/versions/$SPIGOT_VER/builds/$SPIGOT_BUILD/downloads/paper-$SPIGOT_VER-$SPIGOT_BUILD.jar
        fi
    }

    waterafll_wget(){
        if [ -z "$VERSION" ]; then
        # CHECK VERSION FOR WATERFALL
            curl -s https://papermc.io/api/v2/projects/waterfall/ | jq '.' > tmp_ver.json
            cat tmp_ver.json | jq '.versions[]'  > waterfall_ver.tmp
            sed 's/\"//g' waterfall_ver.tmp > tmp
            WATERFALL_VER=$(tail -1 tmp)
            low_echo "Version = $WATERFALL_VER"
            rm -r tmp_ver.json
            rm -r waterfall_ver.tmp
            rm -r tmp
            # CHECK BUILF FOR WATERFALL
            curl -s https://papermc.io/api/v2/projects/paper/versions/$WATERFALL_VER/ | jq '.' > tmp_build.json
            cat tmp_build.json | jq '.builds[]'  > waterfall_ver.tmp
            sed 's/\"//g' waterfall_ver.tmp > tmp
            WATERFALL_BUILD=$(tail -1 tmp)
            low_echo "Build = $WATERFALL_BUILD"
            sleep 4
            rm -r tmp_build.json
            rm -r waterfall_ver.tmp
            rm -r tmp
            #Download and checksum
            wget -q -O waterfall.jar https://papermc.io/api/v2/projects/paper/versions/$WATERFALL_VER/builds/$WATERFALL_BUILD/downloads/paper-$WATERFALL_VER-$WATERFALL_BUILD.jar
        else
            # CHECK BUILF FOR WATERFALL
            curl -s https://papermc.io/api/v2/projects/paper/versions/$VERSION/ | jq '.' > tmp_build.json
            cat tmp_build.json | jq '.builds[]'  > waterfall_ver.tmp
            sed 's/\"//g' waterfall_ver.tmp > tmp
            WATERFALL_BUILD=$(tail -1 tmp)
            low_echo "Version = $VERSION"
            low_echo "Build = $WATERFALL_BUILD"
            sleep 4
            rm -r tmp_build.json
            rm -r waterfall_ver.tmp
            rm -r tmp
            #Download and checksum
            wget -q -O waterfall.jar https://papermc.io/api/v2/projects/paper/versions/$WATERFALL_VER/builds/$WATERFALL_BUILD/downloads/paper-$WATERFALL_VER-$WATERFALL_BUILD.jar
        fi
    }

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
    echo -e "* ${YELLOW} Install Script AutoConfig-Node ${reset}"
    low_echo "Owner: F0cus"
    low_echo "Version: $SCRIPT_VERSION"
    low_echo "Support: $SUPPORT_LINK"
    print_brake 47
    echo -e ""
    echo -e "* ${YELLOW} Checking download URL ${reset}"
    if wget --spider "https://zahrajsi.net/amp/assets/pngs/server-icon.png" 2>/dev/null; then
        SERVER_LINK="YES"
        print_success "Available"
    else
        SERVER_LINK="NO"
    fi
    #exit
    install_var
    backup
    find_instance
#



    # SPIGOT INSTANCE
        if [ "$SERVER_LINK" == "YES" ]; then
            install_spigot(){
                if [ "$INSTANCE" == "SPIGOT" ]; then
                    vars_spigot
                    echo -e " ${BLUE}* ${reset}A spigot was detected!"
                    echo ""
                    low_echo "1. MOTD"
                    low_echo "2. Server-Icon"
                    low_echo "3. Login Plugin (AuthMe)"
                    low_echo "4. Another Plugins (INSTALLER)"
                    echo -e ""
                    print_success "> Inialize installer for spigot"
                    print_brake_A 40
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
                        echo -e ""
                        print_info "> MOTD is already set, by the previous user!"
                    elif [ "$TMP_GREP" == "SET" ]; then
                        echo -e ""
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
                        print_info "> Downloading Server Icon from an external server.. for $INSTANCE"
                        print_success "> Icon set successfully!"
                    fi
                    # Install Login Plugin
                    if [ -d "$Login_D" ] && [ ! "$AUTHME" == "TRUE" ]; then
                        print_info "> Authme plugin is already installed.."
                    else
                        print_info "> Installing AuthMe"
                        if [ ! -d "$S_DIR" ]; then
                            mkdir "$S_DIR"
                        low_echo "Making folder!"
                        fi
                        if [ ! -f "$Login_tar" ]; then
                            low_echo "The $Login_tar file does not exist, Downloading and unpacking"
                            wget -q "https://zahrajsi.net/amp/assets/installer/authme-conf.tar.gz"
                            low_echo "Unzipping the authme-conf.tar.gz"
                            sleep 2
                            tar -zxf authme-conf.tar.gz --directory plugins
                            rm -r authme-conf.tar.gz
                            INSTALL="TRUE"
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
                        if [ ! -d "$W_S_DIR" ]; then
                            mkdir "$W_S_DIR"
                            low_echo "Making folder!"
                        fi
                        if [ ! -f "$W_Login_tar" ]; then
                            low_echo "The $Login_tar file does not exist, they are downloading and unpacking"
                            wget -q "https://zahrajsi.net/amp/assets/installer/$W_Login_tar"
                            low_echo "Unzipping the $W_Login_tar"
                            sleep 2
                            tar -zxf "$W_Login_tar" --directory plugins
                            rm -r "$W_Login_tar"
                            INSTALL="TRUE"
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
                            spigot_wget
                            find_instance
                            install_spigot
                            break 1
                            ;;
                        "Waterfall")
                            set -e
                            low_echo "Downloading Waterfall $WATERFALL_VER".
                            waterafll_wget
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
        echo "$INSTALL"
        echo "$TMP_GREP"
        echo "$AUTHME"
        errors
    }
    debug
else
    print_brake_A 30
    if [ "$INSTALL" = "TRUE" ]; then
        print_success "All DONE!, All changes have been successful!"
    else
        print_error "An error may have occurred during installation!"
    fi
    echo -e ""
    echo -e ""
    low_echo "Thank you for using $SCRIPT_N"
    low_echo "If you wanna support me, let's go here $SUPPORT"
    low_echo "If you want to use the backup use: "
    low_echo "tar -zxf $BACKUP --"
    low_echo ""
    low_echo "Bye!"
fi
