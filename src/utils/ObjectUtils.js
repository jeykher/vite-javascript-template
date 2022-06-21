/* OBJECT UTILS @ JEYKHER PERNIA YENDES */

/**
 * @function        addDinamycObjectProp
 * @description     This method add dynamic object property
 * @param           {object} obj object to add dinamic property
 * @param           {string} propName property name to set on object
 * @param           {any} propValue value to set on dinamyc property
 * @returns         {object}
 */
export const addDinamycObjectProp = (obj, propName, propValue) => {
	obj[propName] = propValue;
};
