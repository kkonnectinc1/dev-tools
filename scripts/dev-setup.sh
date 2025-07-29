#!/bin/bash
# Development environment setup script for kkonnect

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check script execution permissions
if [ ! -x "$0" ]; then
    echo -e "${RED}Script is not executable. Attempting to fix...${NC}"
    chmod +x "$0"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Script permissions fixed. Please rerun the script.${NC}"
        exit 0
    else
        echo -e "${RED}Failed to set execute permissions. Run 'chmod +x $0' manually.${NC}"
        exit 1
    fi
fi

# Check write permissions for ~/dev
DEV_ROOT="$HOME/dev"
if [ ! -w "$HOME" ]; then
    echo -e "${RED}No write permissions in $HOME. Cannot create $DEV_ROOT.${NC}"
    exit 1
fi

# Create directory structure if it doesn't exist
for dir in "$DEV_ROOT" "$DEV_ROOT/projects" "$DEV_ROOT/projects/personal" "$DEV_ROOT/projects/work" \
           "$DEV_ROOT/projects/learning" "$DEV_ROOT/projects/opensource" "$DEV_ROOT/tools" \
           "$DEV_ROOT/tools/bin" "$DEV_ROOT/tools/config" "$DEV_ROOT/scripts" "$DEV_ROOT/docs" "$DEV_ROOT/notes"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Created directory: $dir${NC}"
        else
            echo -e "${RED}Failed to create directory: $dir${NC}"
        fi
    fi
done

# Check Git SSH authentication
echo -e "${GREEN}=== Checking Git SSH Authentication ===${NC}"
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo -e "${GREEN}Git SSH authentication: Configured${NC}"
else
    echo -e "${RED}Git SSH authentication: ❌ Not configured. Please set up SSH keys for Git.${NC}"
fi
echo ""

# Development environment info
echo -e "${GREEN}=== Development Environment Info ===${NC}"
echo "OS: WSL2 Ubuntu"
echo "User: $(whoami)"
echo "Home: $HOME"
echo "Current: $(pwd)"
echo "Dev Structure: $DEV_ROOT"
echo "Editor: VS Code with Remote-WSL"
echo "Version Control: Git with SSH authentication"
echo ""

# Tool versions
echo -e "${GREEN}=== Tool Versions ===${NC}"
echo "Git: $(git --version)"
echo "Node: $(node --version 2>/dev/null || echo -e "${RED}❌ Node.js not installed${NC}")"
echo "npm: $(npm --version 2>/dev/null || echo -e "${RED}❌ npm not available${NC}")"
echo "Python: $(python3 --version 2>/dev/null || echo -e "${RED}❌ Python3 not installed${NC}")"
echo "VS Code: $(code --version 2>/dev/null | head -1 || echo -e "${RED}❌ VS Code CLI not available${NC}")"

# Check NVM
if command -v nvm &> /dev/null; then
    echo "NVM: $(nvm --version)"
else
    echo -e "NVM: ${RED}❌ Not installed${NC}"
fi
echo ""

# Check navigation aliases
echo -e "${GREEN}=== Navigation Aliases ===${NC}"
for alias_cmd in dev projects personal; do
    if alias "$alias_cmd" &> /dev/null; then
        echo "$alias_cmd: $(alias "$alias_cmd" | cut -d= -f2-)"
    else
        echo -e "$alias_cmd: ${RED}❌ Not configured${NC}"
    fi
done
echo ""

# Check Git aliases
echo -e "${GREEN}=== Git Aliases ===${NC}"
for git_alias in st co br ci lg; do
    if git config --get alias."$git_alias" > /dev/null; then
        echo "git $git_alias: $(git config --get alias."$git_alias")"
    else
        echo -e "git $git_alias: ${RED}❌ Not configured${NC}"
    fi
done
echo ""

# Directory structure
echo -e "${GREEN}=== Directory Structure ===${NC}"
echo "Dev root: $DEV_ROOT"
echo "Projects: $DEV_ROOT/projects/{personal,work,learning,opensource}"
echo "Tools: $DEV_ROOT/tools/{bin,config}"
echo "Scripts: $DEV_ROOT/scripts"
echo "Docs: $DEV_ROOT/docs"
echo "Notes: $DEV_ROOT/notes"
echo ""
echo -e "${GREEN}Environment ready! 🚀${NC}"
