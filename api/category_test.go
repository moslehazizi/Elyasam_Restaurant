package api

import (
	"bytes"
	"database/sql"
	"encoding/json"
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/gin-gonic/gin"
	mockdb "github.com/moslehazizi/Elyasam_Restaurant/db/mock"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
	"github.com/moslehazizi/Elyasam_Restaurant/util"
	"github.com/stretchr/testify/require"
	"go.uber.org/mock/gomock"
)


func TestCreateCategory(t *testing.T) {
	category := randomCategory()

	testCases := []struct {
		name          string
		body          gin.H
		buildStubs    func(store *mockdb.MockStore)
		checkResponse func(recorder *httptest.ResponseRecorder)
	}{
		{
			name: "OK",
			body: gin.H{
				"category_title": category.CategoryTitle,
				"category_icon":  category.CategoryIcon,
			},
			buildStubs: func(store *mockdb.MockStore) {
				arg := db.CreateCategoryParams{
					CategoryTitle: category.CategoryTitle,
					CategoryIcon:  category.CategoryIcon,
				}
				store.EXPECT().CreateCategory(gomock.Any(), gomock.Eq(arg)).Times(1).Return(category, nil)
			},
			checkResponse: func(recorder *httptest.ResponseRecorder) {
				require.Equal(t, http.StatusOK, recorder.Code)
				requireBodyMatchCategoryRequest(t, recorder.Body, category)
			},
		},
		{
			name: "InternalError",
			body: gin.H{
				"category_title": category.CategoryTitle,
				"category_icon":  category.CategoryIcon,
			},
			buildStubs: func(store *mockdb.MockStore) {
				arg := db.CreateCategoryParams{
					CategoryTitle: category.CategoryTitle,
					CategoryIcon:  category.CategoryIcon,
				}
				store.EXPECT().CreateCategory(gomock.Any(), gomock.Eq(arg)).Times(1).Return(db.Category{}, sql.ErrConnDone)
			},
			checkResponse: func(recorder *httptest.ResponseRecorder) {
				require.Equal(t, http.StatusInternalServerError, recorder.Code)
			},
		},
		{
			name: "InvalidContext",
			body: gin.H{
				"category_title": "",
				"category_icon":  "",
			},
			buildStubs: func(store *mockdb.MockStore) {
				store.EXPECT().CreateCategory(gomock.Any(), gomock.Any()).Times(0)
			},
			checkResponse: func(recorder *httptest.ResponseRecorder) {
				require.Equal(t, http.StatusBadRequest, recorder.Code)
			},
		},
	}

	for i := range testCases {
		tc := testCases[i]

		t.Run(tc.name, func(t *testing.T) {
			ctrl := gomock.NewController(t)
			defer ctrl.Finish()

			store := mockdb.NewMockStore(ctrl)
			tc.buildStubs(store)

			server := NewServer(store)
			recorder := httptest.NewRecorder()

			// Marshal body data to JSON
			data, err := json.Marshal(tc.body)
			require.NoError(t, err)

			url := "/post/category"
			request, err := http.NewRequest(http.MethodPost, url, bytes.NewReader(data))
			require.NoError(t, err)

			server.router.ServeHTTP(recorder, request)
			tc.checkResponse(recorder)
		})

	}

}

func randomCategory() db.Category {
	return db.Category{
		ID:           util.RandomInt(1, 1000),
		CategoryTitle: util.RandomName(),
		CategoryIcon:  util.RandomName(),
	}
}

func requireBodyMatchCategory(t *testing.T, body *bytes.Buffer, category db.Category) {
	data, err := ioutil.ReadAll(body)
	require.NoError(t, err)

	var gotCategory db.Category
	err = json.Unmarshal(data, &gotCategory)
	require.NoError(t, err)
	require.Equal(t, category, gotCategory)
}

func requireBodyMatchCategories(t *testing.T, body *bytes.Buffer, c_categories []db.Category) {
	data, err := ioutil.ReadAll(body)
	require.NoError(t, err)

	var gotCategories []db.Category
	err = json.Unmarshal(data, &gotCategories)
	require.NoError(t, err)
	require.Equal(t, c_categories, gotCategories)
}

func requireBodyMatchCategoryRequest(t *testing.T, body *bytes.Buffer, category db.Category) {
	data, err := ioutil.ReadAll(body)
	require.NoError(t, err)

	var gotCategory db.Category
	err = json.Unmarshal(data, &gotCategory)
	require.NoError(t, err)
	require.Equal(t, category.CategoryTitle, gotCategory.CategoryTitle)
	require.Equal(t, category.CategoryIcon, gotCategory.CategoryIcon)
}