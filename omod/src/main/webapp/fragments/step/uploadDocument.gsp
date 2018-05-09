
<% ui.includeJavascript("registrationapp","fileinput.js")
ui.includeCss("registrationapp","fileinput.css")
 %>

<script >

	jq(':file').on('change', function() {
    var file = this.files[0];
    if (file.size > 1024) {
        alert('max upload size is 1k')
    }

    // Also see .name, .type
});
jq(document).ready( function() {

var url = emr.fragmentActionLink("registrationapp", "UploadDocument", "uploadFile"); 

jq('#fileUploadBtn').on('click', function() {

    jq.ajax({
        // Your server script to process the upload
        url: url+"patientName=Name",
        type: 'POST',

        // Form data
        data: new FormData(jq('form')[0]),

        // Tell jQuery not to process data or worry about content-type
        // You *must* include these options!
        cache: false,
        contentType: false,
        processData: false,

        // Custom XMLHttpRequest
        xhr: function() {
            var myXhr = jq.ajaxSettings.xhr();
            if (myXhr.upload) {
                // For handling the progress of the upload
                myXhr.upload.addEventListener('progress', function(e) {
                    if (e.lengthComputable) {
                        jq('progress').attr({
                            value: e.loaded,
                            max: e.total,
                        });
                    }
                } , false);
            }
            return myXhr;
        },
        success:function(){
        	jq("#next-step-4").click();
        }
        
    });
});

});

</script>


<div class="row">
<div class="col-lg-6">

<input class="display-inline" name="file" type="file" />
    <input id="fileUploadBtn" type="button" value="Upload" />
    
    </div>
    
    </div>
    
    
    


