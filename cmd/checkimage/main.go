package main

import (
	"fmt"
	"os"

	"github.com/google/go-containerregistry/pkg/name"
	"github.com/google/go-containerregistry/pkg/v1/remote"
)

// This executable's exits with exit code 0 if the first argument
// is a docker image that can be found, and non-zero otherwise.
//
func main() {
	imageName := os.Args[1]

	exists, err := ImageExists(imageName)
	if err != nil {
		fmt.Fprintln(os.Stderr, err.Error())
		os.Exit(2)
	}

	if exists {
		os.Exit(0)
	} else {
		os.Exit(1)
	}
}

// Returns true if the specified image exists, false otherwise
func ImageExists(imageName string) (bool, error) {
	ref, err := name.ParseReference(imageName)
	if err != nil {
		return false, err
	}

	_, err = remote.Head(ref)
	if err != nil {
		return false, nil
	}

	return true, nil
}
