<script>
    jq(document).ready(function () {

        var url = emr.fragmentActionLink("registrationapp", "UploadDocument", "uploadFile");

        jq('#skipPictureUpload').on('click', function (e) {
            e.preventDefault();
            jq("#next-step-6").click();
        })

        jq('#picUploadBtn').on('click', function () {

            jq.ajax({
                // Your server script to process the upload
                url: url + "patientName=Name",
                type: 'POST',

                // Form data
                data: new FormData(jq('form')[0]),

                // Tell jQuery not to process data or worry about content-type
                // You *must* include these options!
                cache: false,
                contentType: false,
                processData: false,

                // Custom XMLHttpRequest
                xhr: function () {
                    var myXhr = jq.ajaxSettings.xhr();
                    if (myXhr.upload) {
                        // For handling the progress of the upload
                        myXhr.upload.addEventListener('progress', function (e) {
                            if (e.lengthComputable) {
                                jq('progress').attr({
                                    value: e.loaded,
                                    max: e.total,
                                });
                            }
                        }, false);
                    }
                    return myXhr;
                },
                success: function () {
                    jq("#next-step-6").click();
                }

            });
        });

    });
</script>



<h2>Upload Profile Picture Of Patient</h2>
<div class="row">
    <div class="col-lg-6">
        <input class="display-inline low-width" name="file" type="file" />
        <input id="picUploadBtn" type="button" value="Upload HSU Picture" />
    </div>
</div>


<hr/>

<button class="btn btn-primary" id="skipPictureUpload">Skip Profile Picture Upload</button>