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

-- name: UpdateUser :one

UPDATE
    "users"
SET
    "Password" = sqlc.arg('Password') :: VARCHAR(100)
WHERE 
    "Id" = sqlc.arg('Id') :: INT
    AND "Email" = sqlc.arg('Email') :: VARCHAR(100)
RETURNING *;


-- name: GetUser :one

SELECT
    *
FROM
    "users"
WHERE
    "Id" = sqlc.arg('Id') :: INT
LIMIT 1;