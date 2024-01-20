// firebaseをimportしています
import firebase from "firebase/app";

const firebaseConfig = {
	// 先程Firebaseにアプリを追加するところでコピーしたコードを追加
	apiKey: "AIzaSyBkc753CjSAaO0-niXn5jMSOoNZcP5T9pA",
	authDomain: "tech-camp-vol13.firebaseapp.com",
	projectId: "tech-camp-vol13",
	storageBucket: "tech-camp-vol13.appspot.com",
	messagingSenderId: "299848172445",
	appId: "1:299848172445:web:511dfea008d575beb32574",
	measurementId: "G-444EWVVJDB"
};
// Firebaseのインスタンスが存在しない場合にのみ、インスタンスを作成します
if (!firebase.apps.length) {
	firebase.initializeApp(firebaseConfig);
}

export default firebase;