const formatDate = (dateString: string | Date) => {
    let date = new Date(dateString),
        day = date.getDay(),
        month = date.getMonth(),
        year = date.getFullYear(),
        months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    return months[month] + ' ' + year;
}

export default formatDate;
