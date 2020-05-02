class LoginViewModel {
    get email() {
        return document.getElementsByName("email")[0].value;
    }

    get password() {
        return document.getElementsByName("password")[0].value;
    }

    valid() {
        return this._createValidators()
            .flatMap(validator => validator.valid())
            .filter(msg => msg !== "");
    }

    login() {
        // ログイン
        const xhr = new XMLHttpRequest();
        const method = "post";
        const url = "/api/login";
        const parameters = JSON.stringify(
            {
                email: this.email,
                password: this.password,
            }
        );
        xhr.open(method, url, true);
        xhr.onreadystatechange = function() {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                const status = xhr.status;
                if(status === 0 || (status >= 200 && status < 400)) {
                    location.href = "/talk_list"
                    return;
                    //return console.log(xhr.responseText);
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
    constructor(password) {
        this.password = password;
    }

    valid() {
        let errors = [];
        if(this.password.length < 1) {
            errors.push("パスワードを入力してください。");
        }
        return errors;
    }
}