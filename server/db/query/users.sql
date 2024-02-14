-- name: CreateUser :one

INSERT INTO 
    "users" (
        "FirstName",
        "LastName",
        "Email",
        "Password"
    )
VALUES
    (
        sqlc.arg('FirstName') :: VARCHAR(75),
        sqlc.arg('LastName') :: VARCHAR(75),
        sqlc.arg('Email') :: VARCHAR(100),
        sqlc.arg('Password') :: VARCHAR(100)
    ) RETURNING *;