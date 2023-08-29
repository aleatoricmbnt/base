#!/bin/bash

echo "---------------------------------------------------------------------------------------"
echo "Formatting"
echo "---------------------------------------------------------------------------------------"

echo "---------------------------------------"
echo "Bold"
echo "---------------------------------------"
echo -e "\033[1mThis is bold text.\nIt spans multiple lines.\nIsn't it impressive?\033[0m"

echo "---------------------------------------"
echo "Dim"
echo "---------------------------------------"
echo -e "\033[2mThis is dim text.\nIt's not as prominent.\nBut it still has its charm.\033[0m"

echo "---------------------------------------"
echo "Italic"
echo "---------------------------------------"
echo -e "\033[3mThis is italic text.
It's slanted and stylish.
Perfect for emphasis.\033[0m"
