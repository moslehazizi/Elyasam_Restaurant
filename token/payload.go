package token

import (
	"time"

	"github.com/google/uuid"
)

type Payload struct {
	ID          uuid.UUID `json:"id"`
	Phonenumber string    `json:"phone_number"`
	IssuedAt    time.Time `json:"issued_at"`
	ExpiredAt   time.Time `json:"expired_at"`
}

func NewPayLoad(phonenumber string, duration time.Duration) (*Payload, error) {
	tokenID, err := uuid.NewRandom()
	if err != nil {
		return nil, err
	}
	
	payload := &Payload{
		ID: tokenID,
		Phonenumber: phonenumber,
		IssuedAt:  time.Now(),
		ExpiredAt: time.Now().Add(duration),
	}
	return payload, nil
}
