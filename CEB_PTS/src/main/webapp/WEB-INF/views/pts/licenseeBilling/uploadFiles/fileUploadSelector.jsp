<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<form:form id="myForm" method="post" enctype="multipart/form-data"
		   action="/PTS/UploadingMeterReadingFileS" modelAttribute="model">

	<div class="mb-5">
		<div class="card">
			<div class="container mt-4 mb-4" style="width: 85%;">
				<div class="row">
					<!-- Bill Cycle -->
					<div class="col">
						<div class="selectUnit">
							<label>Bill Cycle</label>
							<div class="input-group">
								<form:input path="billCycle" type="text" id="billCycle"
											class="form-control" readonly="true"/>
							</div>
						</div>
					</div>

					<!-- Division -->
					<div class="col">
						<div class="selectUnit">
							<label>Distribution Division</label>
							<div class="input-group">
								<c:if test="${not empty model.licenseList}">
									<form:select path="division" id="divisionDropdown" class="form-control">
										<c:forEach var="division" items="${model.licenseList}">
											<option value="${division.licenseCode}" label="${division.licenseName}"/>
										</c:forEach>
									</form:select>
								</c:if>
							</div>
						</div>
					</div>

					<!-- Province -->
					<div class="col">
						<div class="selectUnit">
							<label>Province</label>
							<div class="input-group">
								<form:select path="province" id="provinceDropdown" class="form-control">
								</form:select>
							</div>
						</div>
					</div>

					<!-- File Upload -->
					<div class="col">
						<div class="selectUnit">
							<label>Browse File</label>
							<input style="font-size: 0.7rem;" type="file" name="files" multiple class="form-control"/>
						</div>
					</div>

					<!-- Submit Button -->
					<div>
						<div class="ml-5 pt-3">
							<input type="submit" class="btn btnClick" id="click_btn" value="Upload" onclick=" submitForm()" >
<%--							javascript:return confirmUpload();--%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form:form>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function () {
		// ---------------------- Bill Cycle AJAX ------------------------
		$.ajax({
			url: '/PTS/getBillCycle',
			method: 'GET',
			dataType: 'text',
			success: function (data) {
				$('#billCycle').val(data); // ✅ Will now be "436" instead of [object XMLDocument] or <Long>436</Long>
			},
			error: function (err) {
				console.error('Error fetching bill cycle:', err);
			}
		});



		// ---------------------- Province Dropdown Logic ------------------------
		const divDropdown = $('#divisionDropdown');
		const provDropdown = $('#provinceDropdown');
		const provinceList = ${provinceList};

		divDropdown.change(function () {
			let selectedLicenseCode = divDropdown.val();
			filterProvince(selectedLicenseCode);
		});

		function filterProvince(lCode) {
			const filteredProvinces = provinceList.filter(function (province) {
				return province.licenseCode === lCode;
			});
			provDropdown.empty().append(
					filteredProvinces.map(function (province) {
						return $('<option>', {
							value: province.provinceCode,
							text: province.provinceName
						});
					})
			);
		}

		filterProvince('DD1'); // initial render
		// ---------------------- Store Form Data in localStorage ------------------------
		$('#click_btn').click(function (event) {
			event.preventDefault(); // Prevent form submission

			const billCycle = $('#billCycle').val();
			const licenseCode = $('#divisionDropdown').val();
			const provinceCode = $('#provinceDropdown').val();
			const files = $('input[name="files"]')[0].files;

			// Store data in localStorage
			localStorage.setItem('billCycle', billCycle);
			localStorage.setItem('licenseCode', licenseCode);
			localStorage.setItem('provinceCode', provinceCode);

			// Store file details (only names for simplicity)
			const fileNames = [];
			for (let i = 0; i < files.length; i++) {
				fileNames.push(files[i].name);
			}
			localStorage.setItem('files', JSON.stringify(fileNames));

		//	alert('Data stored temporarily in the browser.');
		});

		// ---------------------- Retrieve Stored Data ------------------------
		function retrieveStoredData() {
			const billCycle = localStorage.getItem('billCycle');
			const licenseCode = localStorage.getItem('licenseCode');
			const provinceCode = localStorage.getItem('provinceCode');
			const files = JSON.parse(localStorage.getItem('files'));

			console.log('Stored Data:', { billCycle, licenseCode, provinceCode, files });
		}

		// Call retrieveStoredData() when needed
		retrieveStoredData();
	});

	function submitForm() {
		const form = document.getElementById('myForm');
		const formData = new FormData(form);

		fetch(form.action, {
			method: form.method,
			body: formData
		})
				.then(response => response.text())
				.then(html => {
					const alertBox = document.getElementById('alertBox');
					alertBox.innerHTML = ''; // Clear previous content
					alertBox.innerHTML = html; // Add new content
				})
				.catch(error => {
					console.error('Error:', error);
					const alertBox = document.getElementById('alertBox');
					alertBox.innerHTML = ''; // Clear previous content
					alertBox.innerHTML = '<p>An error occurred while submitting the form.</p>';
				});
	}
</script>


<!-- IndexedDB Script -->
<script>
	// Initialize IndexedDB
	const dbName = "TemporaryFileStorage";
	let db;

	function initDB() {
		const request = indexedDB.open(dbName, 1);

		request.onupgradeneeded = function (event) {
			db = event.target.result;
			if (!db.objectStoreNames.contains("files")) {
				db.createObjectStore("files", { keyPath: "id" });
			}
		};

		request.onsuccess = function (event) {
			db = event.target.result;
			console.log("IndexedDB initialized successfully.");
		};

		request.onerror = function (event) {
			console.error("Error initializing IndexedDB:", event.target.error);
		};
	}

	// Save file to IndexedDB
	function saveFileToDB(file) {
		const transaction = db.transaction(["files"], "readwrite");
		const store = transaction.objectStore("files");

		const fileData = {
			id: "temporaryFile",
			name: file.name,
			content: file,
		};

		const request = store.put(fileData);

		request.onsuccess = function () {
			console.log("File saved to IndexedDB:", file.name);
		};

		request.onerror = function (event) {
			console.error("Error saving file to IndexedDB:", event.target.error);
		};
	}

	// Retrieve file from IndexedDB
	function getFileFromDB() {
		const transaction = db.transaction(["files"], "readonly");
		const store = transaction.objectStore("files");

		const request = store.get("temporaryFile");

		request.onsuccess = function (event) {
			const fileData = event.target.result;
			if (fileData) {
				console.log("File retrieved from IndexedDB:", fileData.name);
				// Use fileData.content for further processing
			} else {
				console.log("No file found in IndexedDB.");
			}
		};

		request.onerror = function (event) {
			console.error("Error retrieving file from IndexedDB:", event.target.error);
		};
	}

	// Delete file from IndexedDB
	function deleteFileFromDB() {
		const transaction = db.transaction(["files"], "readwrite");
		const store = transaction.objectStore("files");

		const request = store.delete("temporaryFile");

		request.onsuccess = function () {
			console.log("File deleted from IndexedDB.");
		};

		request.onerror = function (event) {
			console.error("Error deleting file from IndexedDB:", event.target.error);
		};
	}

	// Event listeners
	$(document).ready(function () {
		initDB();

		$('input[name="files"]').change(function (event) {
			const files = event.target.files;
			if (files.length > 0) {
				saveFileToDB(files[0]); // Save the first file to IndexedDB
			}
		});

		$('#click_btn').click(function (event) {
			event.preventDefault();
			getFileFromDB(); // Retrieve the file when needed
		});
	});
</script>

<!-- Styles -->
<style>
	.selectUnit label,
	.selectUnit select {
		font-size: small;
		margin: 0;
	}
</style>
