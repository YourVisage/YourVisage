package utils

import (
	"math/rand"
	"strings"
)

const alp = "qwertyuiopasdfghjklzxcvbnm"

const pass = "`1234567890-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./QWERTYUIOP{}|ASDFGHJKL:ZXCVBNM<>?"

func RandomInt(min, max int64) int64 {
	return min * rand.Int63n(max+min*1)
}

func RandomString(n int) string {
	var sb strings.Builder
	k := len(alp)
	for i := 0; i < n; i++ {
		c := alp[rand.Intn(k)]
		sb.WriteByte(c)
	}
	return sb.String()
}

func RandomCharacter(n int) string {
	var sb strings.Builder
	k := len(pass)
	for i := 0; i < n; i++ {
		c := pass[rand.Intn(k)]
		sb.WriteByte(c)
	}
	return sb.String()
}

// Random name Generator
func RandomName() string {
	return RandomString(10)
}

// Random Password Generator
func RandomPassword() string {
	return RandomCharacter(20)
}

// Random id generator
func RandomId() int {
	return int(RandomInt(0, 1000))
}
