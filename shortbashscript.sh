while read acc
do
echo -e "Downloading $acc"
wget -q -O $acc.fasta \
 "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=protein&id=$acc&strand=1&rettype=fasta&retmode=text"
done < 639accs.txt
