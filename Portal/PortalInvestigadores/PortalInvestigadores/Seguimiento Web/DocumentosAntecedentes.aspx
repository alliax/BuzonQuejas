<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DocumentosAntecedentes.aspx.cs" Inherits="Seguimiento_Web.DocumentosAntecedentes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<head runat="server">
    <title></title>
</head>

<script>
 
   window.onunload = refreshParent;
    function refreshParent() {
        //window.opener.location.reload();
        if ($("#txtTipo").val() == 1) {
            window.opener.cargarInvolucradosInvestigacion();
        } else {
            window.opener.guardarTema();
            window.opener.cargarModalTema($("#txtId").val());
        }
    }


    $().ready(function () {
        $('#file').change(function () {
            sendFile(this.files[0]);
        });
        $("#save").hide();

        $("#save").click(function () {

            $(".progress-bar").width('0%');
            $(".progress").hide();
            //$("#save").prop('disabled', true);
            $("#save").hide();
            document.getElementById("file").value = "";
        });

    });

    function sendFile(file) {
        var formData = new FormData(); //var formData = new FormData($('form')[0]);

        var file = $('#file')[0].files[0];
        var nombreArchivo = file.name;
        var tipo = $("#txtTipo").val();
        var id = $("#txtId").val();
        var usuarioAlta = $("#txtusuarioAlta").val();

        //console.log(usuarioAlta);
        
        ///get the file and append it to the FormData object
        formData.append('file', $('#file')[0].files[0]);

        ///AJAX request
        $.ajax(
            {
                ///server script to process data
                url: "FileUploadHandler.ashx", //web service
                type: 'POST',
                xhr: function () {
                    var xhr = $.ajaxSettings.xhr();
                    xhr.upload.onprogress = function (e) {
                        //console.log(Math.floor(e.loaded / e.total * 100) + '%');
                        $(".progress-bar").width(Math.floor(e.loaded / e.total * 100) + '%');
                    };
                    return xhr;
                },
                complete: function () {
                    //on complete event    
                    //alert("se subio correctamente");

                    var xhr = $.ajaxSettings.xhr();
                    xhr.upload.onprogress = function (e) {
                        console.log(Math.floor(e.loaded / e.total * 100) + '%');
                    };
                    return xhr;


                },
                progress: function (evt) {
                    //$(".progress").show();
                    //console.log(evt +"progress");
                    //$(".progress-bar").width(evt);
                },
                ///Ajax events
                beforeSend: function (XMLHttpRequest) {
                    $(".progress").show();

                    //var xhr = $.ajaxSettings.xhr();
                    //xhr.upload.onprogress = function (e) {
                    //    console.log(Math.floor(e.loaded / e.total * 100) + '%');
                    //};
                    //return xhr;
                },
                success: function (e) {
                    //$(".progress-bar").width(75);
                    //console.log(e);

                    $.ajax({
                        type: "POST",
                        url: 'UploadFile.aspx/SaveArchivo',
                        // data: {'idDenuncia: ' + idDenuncia },
                        data: JSON.stringify({ 'tipo': tipo, 'id': id, 'nombreOriginal': nombreArchivo, 'nombre': e, 'usuarioAlta': usuarioAlta }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            console.log(data);
                            alert("El archivo se subio correctamente/The file was uploaded successfully");
                            //location.reload();
                            //window.location.href = "v_detalle.aspx?id=" + denuncia;
                            $("#save").prop('disabled', false);
                            $("#save").show();

                            //$(".progress-bar").width(100);
                        },
                        error: function (e) {
                            //console.log(e);
                        }
                    });

                },
                error: function (e) {
                    //errorHandler
                },
                ///Form data
                data: formData,
                ///Options to tell JQuery not to process data or worry about content-type
                cache: false,
                contentType: false,
                processData: false
            });
        ///end AJAX request
    }

    $(function () {
        var allitems = "";
        for (var i = 0; i < localStorage.length; i++) {
            allitems += localStorage.key(i) + ":" + localStorage.getItem(localStorage.key(i)) + ";<br/>"
            if (localStorage.key(i) == "tipo") {
                $("#txtTipo").val(localStorage.getItem(localStorage.key(i)));
            }

            if (localStorage.key(i) == "id") {
                $("#txtId").val(localStorage.getItem(localStorage.key(i)));
            }

            if (localStorage.key(i) == "usuarioAlta") {
                $("#txtusuarioAlta").val(localStorage.getItem(localStorage.key(i)));
            }

        }

        //$("#result").append(allitems);
    })
</script>
<body>

    <div id="container">
        <input type="hidden" id="txtusuarioAlta" runat="server"/>
        <input type="hidden" id="txtTipo" runat="server"/>
        <input type="hidden" id="txtId" runat="server" />

        <div class="card" style="width: 27rem;">
            <div class="card-header">
                <h2>Sube un Archivo/Add Attachment</h2>
            </div>
            <div class="card-body">
                <form id="form1" runat="server" method="post" enctype="multipart/form-data">
            
                    <input name="file" id="file" type="file" />
                    <input id="save" class="btn btn-primary" name="submit" value="Nuevo archivo/New File" type="button"/>

                </form>
                <div class="progress" style="margin-top: 10px; display:none;">
                  <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" ></div>
                </div>
            </div>
        </div>
                     
       <%-- <h2>Sube un Archivo</h2>
        <br />
       --%>

        <%--<div id="result">
        </div>--%>


        <%--<div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
            </div>
            <div class="custom-file">
                <input type="file" class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
                <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
            </div>
        </div>--%>


    </div>
    <style>
        h2 {
            font-family: "Roboto", sans-serif;
            font-size: 26px;
            line-height: 1;
            color: black;
            margin-bottom: 0;
        }

        p {
            font-family: "Roboto", sans-serif;
            font-size: 18px;
            color: black;
        }

        #container {
                margin-top: 30px;
                margin-left: 90px;
        }
            
    </style>

</body>
</html>
