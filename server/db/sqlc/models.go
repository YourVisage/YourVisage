// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.25.0

package db

import (
	"time"
)

type User struct {
	Id        int32
	FirstName string
	LastName  string
	Email     string
	Password  string
	CreatedAt time.Time
}
