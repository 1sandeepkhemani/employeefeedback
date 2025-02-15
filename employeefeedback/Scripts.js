// Show dropdown on hover
document.getElementById("userIcon").addEventListener("mouseover", function () {
    document.getElementById("userDropdown").classList.add("show");
});

// Hide dropdown when mouse leaves
document.getElementById("userDropdown").addEventListener("mouseleave", function () {
    this.classList.remove("show");
});

// Hide dropdown when clicking outside
document.addEventListener("click", function (event) {
    if (!document.getElementById("userIcon").contains(event.target) &&
        !document.getElementById("userDropdown").contains(event.target)) {
        document.getElementById("userDropdown").classList.remove("show");
    }
});