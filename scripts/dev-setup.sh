#!/bin/bash
# Development environment setup script for kkonnect

echo "=== Development Environment Info ==="
echo "User: $(whoami)"
echo "Home: $HOME" 
echo "Current: $(pwd)"
echo "Dev Structure: ~/dev"
echo ""

echo "=== Tool Versions ==="
echo "Git: $(git --version)"
echo "Node: $(node --version 2>/dev/null || echo '❌ Node.js not installed')"
echo "npm: $(npm --version 2>/dev/null || echo '❌ npm not available')"
echo "Python: $(python3 --version 2>/dev/null || echo '❌ Python3 not installed')"
echo "VS Code: $(code --version 2>/dev/null | head -1 || echo '❌ VS Code CLI not available')"

# Check NVM
if command -v nvm &> /dev/null; then
    echo "NVM: $(nvm --version)"
else
    echo "NVM: ❌ Not installed"
fi

echo ""
echo "=== Directory Structure ==="
echo "Dev root: ~/dev"
echo "Projects: ~/dev/projects/{personal,work,learning,opensource}"  
echo "Tools: ~/dev/tools/{bin,config}"
echo "Scripts: ~/dev/scripts"  
echo "Docs: ~/dev/docs"
echo ""
echo "Environment ready! 🚀"
