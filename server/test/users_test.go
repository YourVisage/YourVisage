package test

import (
	"context"
	"testing"
	"time"

	db "github.com/YourVisage/YourVisage/db/sqlc"
	"github.com/YourVisage/YourVisage/utils"
	"github.com/stretchr/testify/require"
)

func createRandomUser(t *testing.T) db.User {
	arg := db.CreateUserParams{
		FirstName: utils.RandomName(),
		LastName:  utils.RandomName(),
		Email:     utils.RandomName(),
		Password:  utils.RandomPassword(),
	}

	user, err := testQueries.CreateUser(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, user)

	// Equal
	require.Equal(t, arg.FirstName, user.FirstName)
	require.Equal(t, arg.LastName, user.LastName)
	require.Equal(t, arg.Email, user.Email)
	require.Equal(t, arg.Password, user.Password)

	// not zero
	require.NotZero(t, user.Id)
	require.NotZero(t, user.CreatedAt)

	return user
}

func TestRandomUser(t *testing.T) {
	createRandomUser(t)
}

func TestGetUser(t *testing.T) {
	 
}

func TestUpdateUser(t *testing.T) {
	user1 := createRandomUser(t)
	arg := db.UpdateUserParams{
		Id:       user1.Id,
		Email:    user1.Email,
		Password: user1.Password,
	}
	user2, err := testQueries.UpdateUser(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, user2)

	// Equal
	require.Equal(t, arg.Id, user2.Id)
	require.Equal(t, arg.Email, user2.Email)
	require.Equal(t, arg.Id, user2.Id)

	// With
	require.WithinDuration(t, user1.CreatedAt, user2.CreatedAt, time.Second)
}
