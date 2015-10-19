  /*/ File API実装チェック
  if (window.File) {
    window.alert("File APIが実装されてます。");
    // File APIが実装されている場合には、dropイベントを登録
    document.getElementById("drop").addEventListener("drop", onDrop, false);
  } else {
    window.alert("本ブラウザではFile APIが使えません");
  }*/

  //Drop領域にドロップした際のファイルのプロパティ情報読み取り処理
  function onDrop(event) 
  {
    var files = event.dataTransfer.files;
    var disp = document.getElementById("disp");
    var name = document.getElementById("name");
    disp.innerHTML ="";
    name.innerHTML ="";

    //ファイルの配列から1つ目のファイルを選択
    var file = files[0];
    
    //FileReaderオブジェクトの生成
    var reader = new FileReader();

    //画像ファイルかテキスト・ファイルかを判定
    if (!file.type.match('image.*')) 
    {
      alert("画像ファイル以外は表示できません。");
    }

    //エラー発生時の処理
    reader.onerror = function (evt) 
    {
      disp.innerHTML = "読み取り時にエラーが発生しました。";
    }

    //画像ファイルの場合の処理
    if (file.type.match('image.*')) 
    {
      //ファイル読取が完了した際に呼ばれる処理
      reader.onload = function (evt) 
      {
        var img = document.createElement('img');
        img.src = evt.target.result;
        img.width=100;
        img.height=100;
        disp.appendChild(img);
        name.innerHTML = file.name;
      }
      // readAsDataURLメソッドでファイルの内容を取得
      reader.readAsDataURL(file);
    }

  //ブラウザ上でファイルを展開する挙動を抑止
  event.preventDefault();
  }

  function onDragOver(event) 
  { 
    //ブラウザ上でファイルを展開する挙動を抑止
    event.preventDefault(); 
  }