#!/bin/bash

# Создаём папку для результатов (если её нет)
mkdir -p results

# Обрабатываем каждый .vcf.gz файл в текущей папке
for vcf_file in *.vcf.gz; do
    # Получаем имя образца (без расширения .vcf.gz)
    sample_name="${vcf_file%.vcf.gz}"
    
    echo "Обработка образца: $sample_name"
    
    # 1. Создаём индекс .tbi (если его нет)
    if [ ! -f "${vcf_file}.tbi" ]; then
        echo "Создаём индекс для $vcf_file..."
        tabix -p vcf "$vcf_file"
    fi
    
    # 2. Извлекаем митохондриальные варианты (chrM)
    echo "Фильтруем chrM..."
    bcftools view -r chrM "$vcf_file" -o "${sample_name}.mt.vcf.gz" -Oz
    
    # 3. Запускаем HaploGrep3
    echo "Определяем гаплогруппу..."
    ./haplogrep3 classify \
        --in "${sample_name}.mt.vcf.gz" \
        --out "results/${sample_name}_haplogroup.txt" \
        --tree phylotree-fu-rcrs@1.2
    
    # Удаляем временный .mt.vcf.gz (если не нужен)
    # rm "${sample_name}.mt.vcf.gz"
    
    echo "Готово! Результат в results/${sample_name}_haplogroup.txt"
    echo "----------------------------------------"
done

echo "Все образцы обработаны. Результаты в папке results/"
