package main

import (
	"bufio"
	"fmt"
	"os"
	//"strings"
)

func main() {
	reader := bufio.NewReader(os.Stdin)

	fmt.Println("Welcome to the program!")
	fmt.Println("Please select an option from the following:")

	fmt.Println("1. Option 1")
	fmt.Println("2. Option 2")
	fmt.Println("3. Option 3")

	fmt.Print("Enter your choice (1, 2, or 3): ")
	input, _ := reader.ReadString('\n')
	//input = strings.TrimSpace(input) // Remove leading and trailing whitespace

	switch input {
	case "1":
		fmt.Println("You selected Option 1")
	case "2":
		fmt.Println("You selected Option 2")
	case "3":
		fmt.Println("You selected Option 3")
	default:
		fmt.Println("Invalid choice. Please try again.")
	}
}
