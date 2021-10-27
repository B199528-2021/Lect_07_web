# Step 1: small shell script to get query_key and WebEnv
# Define a couple of variables that we know already
beast="Cosmoscarta"
db="nucleotide"

# Run wget, get the portions of the XML output we want "on the fly" using awk
wget -qO- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=$db&term=$beast&usehistory=y" | awk '{
## Is this the third line
if(FNR==3)
{
split($0,xml_line_split,"<|>");
query_key=xml_line_split[17];
WebEnv=xml_line_split[21];
print query_key > "query_key";
print WebEnv > "WebEnv";
exit;}}'

# Step 2: set our shell variables, now that we have them
query_key=$(cat query_key)
echo $query_key

# Yours will be different... 
WebEnv=$(cat WebEnv)
echo $WebEnv

# Step 3: now we can do the efetch component of the search (one line)
wget -qO cosmoscarta_sequences.fasta "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=$db&query_key=$query_key&WebEnv=$WebEnv&rettype=fasta&retmode=text"

# Check what we got back
head -3 cosmoscarta_sequences.fasta

# How many sequences?
grep -c ">" cosmoscarta_sequences.fasta

# What sequences were they? Get first three grep matches
grep -m3 ">" cosmoscarta_sequences.fasta


