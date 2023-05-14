# ChatWebsite_NodeJS
채팅웹사이트

##	홈페이지 화면
#### 로그인 페이지  
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/2ed90f3a-4a68-4451-8596-a00d86ab856f)
#### 회원가입 페이지  
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/8e20d2bc-b2a0-4d53-a5f3-e74de2833166)  
소스코드는 하단으로 스크롤 하면 있다. 회원가입 시 중복된 아이디나 닉네임을 사용하면 회원가입이 되지 않는다. 또한 특정 폼이 채워지지 않았을 경우에도 회원가입 되지 않는다. 
 
#### 연락처 페이지
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/4f4dab1d-dfe5-447c-8ef7-08b5699f9b03)  
 기본적인 연락처들이다. 계정이 소유한 연락처 목록이 표시되며, 채팅 버튼을 입력하면 채팅을 시작할 수 있다. 연락처 대상이 비회원이면 '가입되지 않은 사용자!' 를 출력한다.
#### 연락처 추가 페이지
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/cbd38601-b789-408b-b184-6d486818af58)
#### 가입되지 않은 사용자와의 채팅 시
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/a8d57641-f9b6-4c6d-a6c7-bf3c8481e85e)
#### 채팅 페이지
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/a4e285df-6563-4453-bace-24a543fef1e9)  
사용자가 가지고 있는 채팅방이 리스트에 표시된다. 리스트를 클릭하면 리스트가 가진 방코드로 연결되며, 채팅이 이어서 시작된다. 악의적인 사용자가 메시지 폼에 XSS스크립트를 시도해볼 수 있기 때문에 HTML엔티티로 필터링 처리했다. 보낼 수 있는 최대 문자 개수는 1000개로 제한하여 1000자가 넘어가면 자동으로 1000자 까지만 잘라서 보내진다.  
## 소스코드
이 채팅 웹은 처음으로 만든 웹사이트였기 때문에 소스코드 상에 부족한 점이 많다. 특히 *콜백지옥으로 이뤄진 코드부분*과 최적화되지 않은 SQL구문, 프론트로 넘길 데이터를 JSON과 같은 형태로 정제하지 않음 등의 보완해야할 사항들이 존재한다.  
아래는 실제 코드들이다.

### 회원가입, 로그인 기능  
#### 로그인 기능 코드
![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/99583468-fe81-454c-8eec-11279a49a089)  
기존에 가입된 계정으로 로그인한다. 회원가입 시 사용한 암호방식으로 비밀번호를 일치시킨 후 맞으면 로그인 시킨다. 로그인할 때 계정의 아이디(userid)를 세션에 추가시켜서 여러 코드에서 활용할 수 있도록 만든다.  
#### 회원가입 기능 코드
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/8e8a8ea8-3ef8-484a-8d95-12c3f47db6d8)  
회원가입에 필요한 인자를 POST로 전달받는다. 이때 비밀번호는 간단하게 암호화하고 연결된 DB에 유저생성 쿼리를 전달한다. 길어서 잘린 쿼리문은 코드 2 1에 표기돼 있다.
    
#### 회원가입 쿼리
    INSERT INTO user (userid, password,
    nickname, name, email, phone_number) SELECT ?,?,?,?,?,? FROM dual WHERE NOT
    EXISTS (SELECT * FROM user WHERE userid=? or nickname=?),[userid, c_pw,
    nickname, name, email, phone_number, userid, nickname]


### 채팅 기능
#### 채팅 코드(메인)
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/bd0af7b7-070e-4d11-8177-be769264a1e5)  
채팅페이지에 접근하면 사용자가 가진 방 리스트를 질의해서 결과 값을 ejs로 넘겨준다. 이때 아직 리스트를 선택하지 않았기 때문에 채팅 방 데이터인 data2에는 더미데이터를 넘겨준다.  
#### 채팅 코드(방 코드 접근)
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/5974aecb-8703-47ab-9dd7-7eb2355ca8ab)  
메인 체팅 코드가 전달한 리스트를 클릭해서 방 코드가 인자로 전달되면 작동하는 코드다. 채팅 방 데이터를 질의 후 결과값을 출력한다. 로그인한 사용자와 채팅하고 있는 상대방을 구분하기 위해서 사용자의 닉네임 값을 함께 전달한다. 길어서 잘린 쿼리문은 아래에 표기돼 있다.  

#### 사용자가 가진 방 목록+목록에 출력 될 최근 메시지 쿼리 

    select * from messages where
    (roomidx,datedata) in (select roomidx,max(datedata) from messages
    where(roomidx) in (select roomidx from chatRoomAttendant where userid= ? )
    group by roomidx), [request.session.owner]


#### 채팅 코드(연락처를 통한 채팅)
 
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/167d8856-34fc-497d-8eaa-d03e66e6707f)  

연락처 페이지에서 채팅 버튼을 누르면 실행되는 코드이다. 채팅을 진행할 상대방이 홈페이지에 가입된 사용자인지 질의한다. 아니라면 오류 페이지를 출력하고 사용자가 존재하면 채팅을 시작할 준비를 한다.  
  
채팅 시작 과정은 4단계이다.
1.	사용자 간의 채팅 방이 생성돼 있으면 그림 2 4에 인자를 전달한다.
2.	1.이 아니라 새로운 채팅이면 랜덤 코드로 방을 생성한다.
3.	새로 만들어진 방에 참가자 두 명을 포함시킨다.
4.	그림 2 4에 인자를 전달한다.  
  
인자는 방코드를 전달하게 되며 프로세스가 모두 완료되면 사용자는 채팅을 할 수 있다.
#### 동시 소유중인 방 쿼리
    
    SELECT a.roomidx from
    chatRoomAttendant a inner join chatRoomAttendant b on a.roomidx = b.roomidx
    and b.userid=? where a.userid=?,[request.session.owner, user]



채팅을 신청한 사용자와 채팅 할 사용자가 동시에 소유하고 있는 방 코드를 질의하는 쿼리문이다. 동시에 소유한 방 코드가 없으면 채팅방이 없는 것으로 간주한다.  
### 소켓(Socket) 실시간 방(room)통신
#### 채팅 코드(실시간 통신) 
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/b2ff6ca2-59a8-448f-96e7-c6ed3a4bce3c)  
실시간 방 단위 통신을 구현한 소켓 코드이다. 실시간 데이터에 포함시키기 위해 세션에서 사용자 이름과 최근에 접속한 방코드를 입력 받는다.  
  
메시지가 1000자가 넘어가면 초과된 메시지는 모두 잘라버린다. 반대로 아무것도 입력하지 않았을 경우 보내지도 않고 저장하지도 않는다.  
  
세션에 저장된 아이디를 DB에 질의하여 닉네임으로 바꾸고 데이터를 보내기 전 먼저 DB에 저장한다. 저장 후에는 지정된 방 번호(소켓번호)로 데이터를 전달하고 방에 ‘message’ 이벤트를 방출한다.  

 #### 메시지 저장 쿼리
    insert into messages (roomidx,
    datedata, sender, message) SELECT ?,?,?,? FROM dual WHERE NOT EXISTS
    (SELECT * FROM messages WHERE datedata=? and sender=? and message=?)


    ,[roomCode, data.date, nickname2,
    data.message, data.date, nickname2, data.message]

 
### 소켓 통신 시 XSS스크립트 방지
#### XSS스크립트 방지 코드  
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/a9ff5125-c3d4-43ce-b4bf-0c8acefed2f2)  

웹 요소로 사용될 수 있는 특정 데이터를 필터링 해서 HTML엔티티로 변환시키는 코드이다. 데이터를 처리하기 전에 먼저 데이터를 변환시킨다.  

#### 처리 결과
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/c83cdc5b-5edf-4a20-8a90-d19bf23a69f7)  
변환된 태그의 모습이다. 웹 브라우저 상에서는 변환된 문자 코드가 아닌 정상적인 데이터로 표기된다.  
### Jquery 기능
#### 스크롤 자동 하강
 ![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/cfc3ae53-51cb-4fb6-9db5-46686063f223)  

Jquery에서 메시지가 전달되면 스크롤을 자동으로 내려주는 코드이다.
#### 전달받은 실시간 메시지 출력
![image](https://github.com/koDove/ChatWebsite_NodeJS/assets/96663170/dac82ca0-fa81-4daa-a6b7-af5c157127dd)  
사용자가 보낸 데이터를 폼에 맞춰 정렬하기 위한 코드다. 보낸 사용자가 자신이면 오른쪽, 보낸 사용자가 다른 사람이면 메시지를 왼쪽에 출력한다.  
