document.addEventListener("turbo:load", function () {
	const table = document.getElementById("quick-search-table")
	if (table && !$.fn.dataTable.isDataTable("#quick-search-table")) {
		$("#quick-search-table").DataTable()
	}
})
