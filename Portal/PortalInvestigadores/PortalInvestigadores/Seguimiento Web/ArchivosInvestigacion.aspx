<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ArchivosInvestigacion.aspx.cs" Inherits="Seguimiento_Web.ArchivosInvestigacion" %>

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

    $(document).ready(function () {
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
        var idQueja = sessionStorage.getItem("sIdQueja");  

        var url_string = window.location;
        var url = new URL(url_string);
        var idForm = url.searchParams.get("idForm");

        formData.append('file', $('#file')[0].files[0]);
        formData.append('idQueja', idQueja);
        formData.append('idForm', idForm);
        ///AJAX request
        $.ajax(
            {
                url: "HandlerInvestigador.ashx", //web service
                data: formData,
                type: 'POST',
                xhr: function () {
                    var xhr = $.ajaxSettings.xhr();
                    xhr.upload.onprogress = function (e) {
                        //console.log(Math.floor(e.loaded / e.total * 100) + '%');
                        $(".progress-bar").width(Math.floor(e.loaded / e.total * 100) + '%');
                    };
                    return xhr;
                },
                beforeSend: function (XMLHttpRequest) {
                    $(".progress").show();
                },
                success: function (e) {
                    window.close();

                },
                complete: function () {
                    $(".progress-bar").width(0);
                    var xhr = $.ajaxSettings.xhr();
                    xhr.upload.onprogress = function (e) {
                        console.log(Math.floor(e.loaded / e.total * 100) + '%');
                    };
                    return xhr;

                },
                error: function (e) {
                    alert("Error System")
                },
                cache: false,
                contentType: false,
                processData: false
            });

    }

    function refreshParent() {
        //window.opener.location.reload();
        if ($("#txtTipo").val() == 1) {
            window.opener.cargarInvolucradosInvestigacion();
        } else {
            window.opener.guardarTema();
            window.opener.cargarModalTema($("#txtId").val());
        }
    }
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