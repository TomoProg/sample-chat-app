class SignupViewModel {
    get email() {
        return document.getElementsByName("email")[0].value;
    }

    get password() {
        return document.getElementsByName("password")[0].value;
    }

    get password2() {
        return document.getElementsByName("password2")[0].value;
    }

    get userName() {
        return document.getElementsByName("user_name")[0].value;
    }

    valid() {
        return this._createValidators()
            .flatMap(validator => validator.valid())
            .filter(msg => msg !== "");
    }

    create() {
        // ユーザ登録
        const xhr = new XMLHttpRequest();
        const method = "post";
        const url = "/api/signup";
        const parameters = JSON.stringify(
            {
                email: this.email,
                password: this.password,
                user_name: this.userName,
            }
        );
        xhr.open(method, url, true);
        xhr.onreadystatechange = function() {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                const status = xhr.status;
                if(status === 0 || (status >= 200 && status < 400)) {
                    return console.log(xhr.responseText);
                }
                else {
                    return console.log("error!!!");
                }
            }
        };
        xhr.send(parameters);
    }

    _createValidators() {
        return [
            new EMailValidator(this.email),
            new PasswordValidator(this.password, this.password2),
            new UserNameValidator(this.userName),
        ];
    }
}

class EMailValidator {
    constructor(email) {
        this.email = email;
    }

    valid() {
        let errors = [];
        if(this.email.trim().length < 1) {
            errors.push("メールアドレスを入力してください。");
        }
        return errors;
    }
}

class PasswordValidator {
    constructor(password, password2) {
        this.password = password;
        this.password2 = password2;
    }

    valid() {
        let errors = [];
        if(this.password.length < 1) {
            errors.push("パスワードを入力してください。");
        }
        if(this.password !== this.password2) {
            errors.push("確認用のパスワードが異なります。");
        }
        return errors;
    }
}

class UserNameValidator {
    constructor(userName) {
        this.userName = userName;
    }

    valid() {
        let errors = [];
        if(this.userName.trim().length < 1) {
            errors.push("ユーザ名を入力してください。");
        }
        return errors;
    }
}