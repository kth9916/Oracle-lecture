show user;

-- 최고 관리자 계정 (sys) : 계정을 생성할 수 있는 권한을 가지고 있다.
-- 아이디 : usertest01, 암호 : 1234
Create user usertest01 identified by 1234;

-- 계정과 암호를 생성했다고 해서 오라클에 접속할 수 있는 권한을 부여 받아야 접속 가능

-- System Privileges : 
    -- Create Session : 오라클에 접속할 수 있는 권한
    -- Create table : 오라클에서 테이블을 생성할 수 있는 권한.
    -- Create Sequence : 시퀀스 생성할 수 있는 권한
    -- Create view : 뷰를 생성할 수 있는 권한

-- 생성한 계정에게 오라클에 접속할 수 있는 