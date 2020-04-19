// JSロード
appendScript("/js/signup/signup_view_model.js");

function createAccount() {
    const viewModel = new SignupViewModel();

    // エラーメッセージをクリア
    document.querySelector("#error_msg").textContent = null;

    // バリデーション
    const errors = viewModel.valid();
    if(errors.length > 0) {
        errors.forEach(function(error) {
            const elem = document.createElement("p");
            const text = document.createTextNode(error);
            elem.appendChild(text);
            document.querySelector("#error_msg").appendChild(elem);
        });
        return false;
    }

    // ユーザ登録
    const result = viewModel.create();
}
