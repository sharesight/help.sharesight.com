/**
 * Converts a string to a valid anchor ID by:
 * - Converting to lowercase
 * - Replacing spaces and special characters with hyphens
 * - Removing any non-alphanumeric characters except hyphens
 */
export const stringToAnchorId = (str: string): string => {
  return str
    .toLowerCase()
    .replace(/[^a-z0-9\s-]/g, '') // Remove special characters except spaces and hyphens
    .replace(/\s+/g, '-') // Replace spaces with hyphens
    .replace(/-+/g, '-') // Replace multiple hyphens with single hyphen
    .replace(/^-|-$/g, ''); // Remove leading/trailing hyphens
};
