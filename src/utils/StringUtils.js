/* STRING UTILS @ JEYKHER PERNIA YENDES */

/**
 * @function        capitalizeString
 * @description     This method capitalize string
 * @param           {str} st to capitalize
 * @returns         {string}
 */
export const capitalizeString = (str) => {
	let formattedString = str
		.trim()
		.toLowerCase()
		.replace(/\w\S*/g, (w) => w.replace(/^\w/, (c) => c.toUpperCase()));
	return formattedString;
};

/**
 * @function        isPalindrome
 * @description     This method check if word is palindromo or not
 * @param           {string} st Word to check
 * @returns         {boolean}
 */
export const isPalindrome = (str) => {
	const strReversed = str.split("").reverse().join("");
	return strReversed === str ? true : false;
};

/**
 * @function		searchString
 * @description		This method check if one string contain string or character coinciden inside of this one
 * @param			{strSearch} stringToSearch string or character to search on word or string
 * @param			{str} str string to search coinciden
 * @returns			{boolean}
 */
export const searchString = (stringToSearch, str) => {
	if (str.search(stringToSearch) !== -1) {
		return true;
	}
	return false;
};
