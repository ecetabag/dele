#!/bin/bash
set -e
cd "$(dirname "$0")"
mkdir -p audio

echo "Looking for an installed Spanish macOS voice..."
VOICE=$(say -v "?" | awk '$2 ~ /^es_/ {print $1; exit}')
if [ -z "$VOICE" ]; then
  echo "No Spanish voice was found."
  echo "Install one in System Settings > Accessibility > Read & Speak > System voice, then run this file again."
  read -p "Press Return to close..."
  exit 1
fi
echo "Using Spanish voice: $VOICE"

echo 'Generating clear_spanish_1.wav...'
say -v "$VOICE" -r 185 -o "audio/clear_spanish_1.aiff" 'Atención, pasajeros. El tren con destino a Sevilla saldrá del andén número cuatro con diez minutos de retraso. Les recomendamos permanecer cerca del andén y escuchar los próximos avisos.'
afconvert -f WAVE -d LEI16@44100 "audio/clear_spanish_1.aiff" "audio/clear_spanish_1.wav"
rm -f "audio/clear_spanish_1.aiff"

echo 'Generating clear_spanish_2.wav...'
say -v "$VOICE" -r 185 -o "audio/clear_spanish_2.aiff" 'Buenos días. Le llamamos de la clínica para informarle de que su cita del martes a las nueve se ha cambiado al miércoles a las once y media. Si ese horario no le conviene, llámenos antes de las seis.'
afconvert -f WAVE -d LEI16@44100 "audio/clear_spanish_2.aiff" "audio/clear_spanish_2.wav"
rm -f "audio/clear_spanish_2.aiff"

echo 'Generating clear_spanish_3.wav...'
say -v "$VOICE" -r 185 -o "audio/clear_spanish_3.aiff" 'Estimados clientes. Hoy el supermercado cerrará a las ocho de la tarde, una hora antes de lo habitual, por trabajos de mantenimiento. Mañana abriremos normalmente a las nueve.'
afconvert -f WAVE -d LEI16@44100 "audio/clear_spanish_3.aiff" "audio/clear_spanish_3.wav"
rm -f "audio/clear_spanish_3.aiff"

echo 'Generating clear_spanish_4.wav...'
say -v "$VOICE" -r 185 -o "audio/clear_spanish_4.aiff" 'El curso de conversación empieza el cinco de septiembre. Las clases son los lunes y miércoles de seis a siete y media de la tarde. Para inscribirse, hay que completar el formulario antes del treinta de agosto.'
afconvert -f WAVE -d LEI16@44100 "audio/clear_spanish_4.aiff" "audio/clear_spanish_4.wav"
rm -f "audio/clear_spanish_4.aiff"

echo 'Generating clear_spanish_5.wav...'
say -v "$VOICE" -r 185 -o "audio/clear_spanish_5.aiff" 'Les recordamos que el desayuno se sirve de siete a diez de la mañana en la primera planta. Los sábados y domingos termina a las once. Para pedir desayuno en la habitación, marque el número cinco.'
afconvert -f WAVE -d LEI16@44100 "audio/clear_spanish_5.aiff" "audio/clear_spanish_5.wav"
rm -f "audio/clear_spanish_5.aiff"

echo ""
echo "Done. Clear Spanish audio files were generated in the audio folder."
echo "Now double-click START_APP.command."
read -p "Press Return to close..."