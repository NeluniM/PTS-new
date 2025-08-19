<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${model.fileNameConflict}">
    <div id="fileConflictAlert">
        <p>File <strong>${model.originalFileName}</strong> already exists. Do you want to overwrite or cancel upload file?</p>
        <form id="myForm" method="post" action="/PTS/uploadingMeterReadingFileS">
            <button type="button" class="btn btnClick" id="overwriteButton" onclick="handleOverwrite()">Yes</button>
            <button type="button" class="btn btnClick" id="cancelButton" onclick="handleCancel()">No</button>
        </form>
    </div>
</c:if>

<style>
    #fileConflictAlert {
        background-color: #ffffff; /* Light red background for alert */
        color: #721c24; /* Dark red text color */
        border: 1px solid #f5c6cb; /* Border matching the background */
        border-radius: 5px; /* Rounded corners */
        padding: 15px; /* Padding inside the alert box */
        margin: 20px auto; /* Center the alert box */
        width: 50%; /* Set width of the alert box */
        text-align: center; /* Center-align text */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Add shadow for better visibility */
    }

    #fileConflictAlert p {
        font-size: 16px; /* Font size for the message */
        margin-bottom: 15px; /* Space below the message */
    }

    /*.btn {*/
    /*    background-color: #007bff; !* Blue button background *!*/
    /*    color: #fff; !* White text color *!*/
    /*    border: none; !* Remove border *!*/
    /*    border-radius: 3px; !* Rounded corners for buttons *!*/
    /*    padding: 10px 20px; !* Padding inside buttons *!*/
    /*    cursor: pointer; !* Pointer cursor on hover *!*/
    /*    margin: 5px; !* Space between buttons *!*/
    /*    font-size: 14px; !* Font size for buttons *!*/
    /*}*/
</style>