# Terraform Plan - ANSI_test

This Terraform module is designed for testing purposes and can be used as a starting point for creating new modules. It includes a `main.tf` file and 2 scripts: `script.sh` and `show_ansi.sh`

## Usage

### `script.sh` 

`script.sh` contains the following code

```bash
#!/bin/bash


echo -e "\033[1mThis is bold text.\nIt spans multiple lines.\nIsn't it impressive?\033[0m"

echo " "

echo -e "\033[3mThis is italic text.
It's slanted and stylish.
Perfect for emphasis.\033[0m"

echo " "

echo -e "\033[4mThis is underlined text.
It has a line below.
Highlighting its importance.\033[0m"

echo " "


echo -e "\033[38;5;9mThis text is red.
Second line also should be red!
And this one too.\033[0m"
```
### `show_ansi.sh` 

`show_ansi.sh` contains the following code

```bash
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
echo -e "\033[2mThis is dim text.
It's not as prominent.
But it still has its charm.\033[0m"

echo "---------------------------------------"
echo "Italic"
echo "---------------------------------------"
echo -e "\033[3mThis is italic text.
It's slanted and stylish.
Perfect for emphasis.\033[0m"


echo "---------------------------------------"
echo "Underline"
echo "---------------------------------------"
echo -e "\033[4mThis is underlined text.
It has a line below.
Highlighting its importance.\033[0m"

echo "---------------------------------------"
echo "Blink"
echo "---------------------------------------"
echo -e "\033[5mThis text is blinking.
On, off, on, off, on...
ou can't miss it!\033[0m"

echo "---------------------------------------"
echo "Reverse"
echo "---------------------------------------"
echo -e "\033[7mThis text has reversed colors.
Foreground and background swap.
A unique visual twist.\033[0m"

echo "---------------------------------------"
echo "Hidden"
echo "---------------------------------------"
echo -e "\033[8mThis text is hidden.
Can you see it? Nope, gone!
A vanishing act.\033[0m"

echo "---------------------------------------------------------------------------------------"
echo "Color"
echo "---------------------------------------------------------------------------------------"

echo "---------------------------------------"
echo "Red"
echo "---------------------------------------"
echo -e "\033[38;5;9mThis text is red.
Second line also should be red!
And this one too.\033[0m"




echo -e  "\033[38;5;10mBright Green\033[0m text.
\033[38;5;11mBright Yellow\033[0m text.
\033[38;5;12mBright Blue\033[0m text.
\033[38;5;13mBright Magenta\033[0m text.
\033[38;5;14mBright Cyan\033[0m text."

echo "---------------------------------------------------------------------------------------"
echo "True Color"
echo "---------------------------------------------------------------------------------------"


echo -e "\033[38;2;255;0;0mBright Red\033[0m text.
\033[38;2;0;255;0mBright Green\033[0m text.
\033[38;2;0;0;255mBright Blue\033[0m text."
```

## Structure

### Inputs

This module doesn't require any input variables. Configuration is re-applied on each execution due to timestamp() trigger for only included `null_resource`.

### Outputs

This module doesn't provide any output values.

## Testing

To test this module, follow the steps below:

1. Set custom hook:
   ```bash
   ./script.sh
   ```
   or
   ```bash
   ./show_ansi.sh
   ```

2. Trigger the run

3. Verify the resources created and make any necessary assertions.
