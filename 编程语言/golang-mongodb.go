package main

import (
	"log"
	"fmt"
	"time"
	//"gopkg.in/mgo.v2"
	//"gopkg.in/mgo.v2/bson"
	"github.com/globalsign/mgo"
	"github.com/globalsign/mgo/bson"
)

const (
	mongdburl = "mongodb://admin:antiy666@10.255.175.88:27017/ACD"
)

func GetSession() (*mgo.Session){
	// https://blog.csdn.net/qq_43029154/article/details/82429384
	session, err := mgo.Dial(mongdburl)
	if err != nil {
		log.Fatalf("Create Session: %s\n", err)
	}
	return session
}

func Connect(db, col string)  (*mgo.Session, *mgo.Collection){
	session := GetSession()
	user, pass := "admin", "antiy666"
	err := session.DB(db).Login(user, pass)
	if err != nil {
		panic(err)
	}
	client := session.DB(db).C(col)
	session.SetMode(mgo.Monotonic, true)
	return session, client
}

func Insert(db, col string, doc interface{}) error {
	_, client := Connect(db, col)
	fmt.Println("ggg",doc)
	return client.Insert(doc)
}

type Jg struct {
	Id  bson.ObjectId `bson:"_id,omitempty" json:"id"`
	Val string `bson:"val" json:"val"`
	Ft  time.Time `bson:"ft" json:"ft"`
	Et  time.Time `bson:"et" json:"et"`
	Name string `bson:"name" json:"name"`
}

func main() {
	var db string = "ACD"
	var col string = "test"

	rt := Jg{}
	rt.Val = "JSDu"
	rt.Name = "node"
	//doc := []byte(`{"_id":"jsdu", "name":"hhhh"}`)
	//err := json.Unmarshal(doc, &rt)

	//err := Insert(db, col, &rt)

	//fmt.Print("sdd", err)
	_, client := Connect(db, col)
	err := client.Insert(&rt)
	fmt.Println("sddd", err)
}



