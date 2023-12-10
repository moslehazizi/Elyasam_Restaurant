package util

import (
	"fmt"
	"math/rand"
	"strings"
	"time"
)

const alphabet = "abcdefghijklmnopqrstuvwxyz"

func init() {
	rand.New(rand.NewSource(time.Now().UnixNano()))
}

// RandomInt generates a randon integer value between min and max
func RandomInt(min, max int64) int64 {
	return min + rand.Int63n(max-min+1)
}

// RandomInt32 generates a randon integer value between min and max
func RandomInt32(min, max int64) int32 {
	return int32(min + rand.Int63n(max-min+1))
}

// RandomFloat generates a random float value between min and max
func RandomFloat() float64 {
	return 5 * rand.Float64()
}

// RndomString generates a random string of length n
func RandomString(n int) string {
	var sb strings.Builder
	k := len(alphabet)
	for i := 0; i<n; i++ {
		c := alphabet[rand.Intn(k)]
		sb.WriteByte(c)
	}
	return sb.String()
}

// RndomBytes generates random bytes of length n
func RandomBytes(n int) []byte {
	random_bytes := make([]byte, n) 
	rand.Read(random_bytes)
	return random_bytes
}

// RandomName generates a random name
func RandomName() string {
	return RandomString(6)
}

// RandomEmail generates a random email
func RandomEmail() string {
	return fmt.Sprintf("%s@email.com", RandomString(6))
}