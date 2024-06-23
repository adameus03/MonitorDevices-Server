cmd_Debug/sauas.node := ln -f "Debug/obj.target/sauas.node" "Debug/sauas.node" 2>/dev/null || (rm -rf "Debug/sauas.node" && cp -af "Debug/obj.target/sauas.node" "Debug/sauas.node")
