const tables = document.getElementsByTagName('table');

for (let a = 0; a < tables.length; a++) {
  const table_rows = tables[a].rows;
  for (let i = 1, l = table_rows.length; i < l; i++) {
    for (let k = 0; k < table_rows[0].cells.length; k++) {
      heading = table_rows[0].cells[k];
      td_value = table_rows[i].cells[k];

      if (table_rows[0].cells.length > 3) {
        tables[a].className = 'table_compact';
      }

      // FIXME
      if (heading.innerText === 'Column Header') {
        headingEl = document.createElement('h4');
        headingEl.className += 'heading_complex';
        headingEl.innerText = td_value.innerText;

        if (table_rows[i] && table_rows[i].cells[k]) {
          td_value.innerHTML = '';
          table_rows[i].cells[k].prepend(headingEl);
        }
      } else if (heading.innerText != '') {
        span = document.createElement('span');
        span.innerText = `${heading.innerText}: `;

        if (table_rows[i] && table_rows[i].cells[k]) {
          table_rows[i].cells[k].prepend(span);
        }
      }
    }
  }
}
