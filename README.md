## Import env:
`conda env create -f hail_env.yml`

## Set config path:
```
VCF_DIR = '/vcfs/'  # папка с VCF
VCF_DIR_NEW = '/new/' # папка с VCF для добавления
SEX_TABLE_PATH = 'sids_test.csv' # файл с полом
BASE_DATA_PATH = '/vcfs/cache/combined.mt' # первый пул данных
AF_PATH = '/vcfs/genomes/cache/af.tsv' # кеш частот
```

## Run cells step by step

## Use haplogrep_run.sh for population analysis
