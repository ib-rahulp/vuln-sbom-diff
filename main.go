package main

import (
    "fmt"
    "github.com/google/uuid"
    _ "github.com/mattn/go-sqlite3"
)

func main() {
    id := uuid.New()
    fmt.Println("Generated UUID:", id)
}