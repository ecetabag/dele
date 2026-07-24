#!/bin/bash
set -e
cd "$(dirname "$0")"
mkdir -p audio
PORT=8765

echo "DELE + Fitness App"
echo "------------------"

VOICE=$(say -v "?" | awk '$2 ~ /^es_/ {print $1; exit}')
if [ -z "$VOICE" ]; then
  osascript -e 'display dialog "No Spanish Mac voice was found. Go to System Settings → Accessibility → Read & Speak → System speech language and choose Spanish, then select/download a Spanish voice." buttons {"OK"} default button "OK"' 
  exit 1
fi
echo "Spanish voice: $VOICE"

NEED_AUDIO=0
[ -s "audio/clear_spanish_1.wav" ] || NEED_AUDIO=1
[ -s "audio/clear_spanish_2.wav" ] || NEED_AUDIO=1
[ -s "audio/clear_spanish_3.wav" ] || NEED_AUDIO=1
[ -s "audio/clear_spanish_4.wav" ] || NEED_AUDIO=1
[ -s "audio/clear_spanish_5.wav" ] || NEED_AUDIO=1

if [ "$NEED_AUDIO" -eq 1 ]; then
  echo "Generating clear Spanish listening files..."
  echo "  [1/5] clear_spanish_1.wav"
  say -v "$VOICE" -r 190 -o "audio/clear_spanish_1.aiff" 'Atención, pasajeros. El tren con destino a Sevilla saldrá del andén número cuatro con diez minutos de retraso. Les recomendamos permanecer cerca del andén y escuchar los próximos avisos.'
  afconvert -f WAVE -d LEI16@44100 "audio/clear_spanish_1.aiff" "audio/clear_spanish_1.wav"
  rm -f "audio/clear_spanish_1.aiff"
  echo "  [2/5] clear_spanish_2.wav"
  say -v "$VOICE" -r 190 -o "audio/clear_spanish_2.aiff" 'Buenos días. Le llamamos de la clínica para informarle de que su cita del martes a las nueve se ha cambiado al miércoles a las once y media. Si ese horario no le conviene, llámenos antes de las seis.'
  afconvert -f WAVE -d LEI16@44100 "audio/clear_spanish_2.aiff" "audio/clear_spanish_2.wav"
  rm -f "audio/clear_spanish_2.aiff"
  echo "  [3/5] clear_spanish_3.wav"
  say -v "$VOICE" -r 190 -o "audio/clear_spanish_3.aiff" 'Estimados clientes. Hoy el supermercado cerrará a las ocho de la tarde, una hora antes de lo habitual, por trabajos de mantenimiento. Mañana abriremos normalmente a las nueve.'
  afconvert -f WAVE -d LEI16@44100 "audio/clear_spanish_3.aiff" "audio/clear_spanish_3.wav"
  rm -f "audio/clear_spanish_3.aiff"
  echo "  [4/5] clear_spanish_4.wav"
  say -v "$VOICE" -r 190 -o "audio/clear_spanish_4.aiff" 'El curso de conversación empieza el cinco de septiembre. Las clases son los lunes y miércoles de seis a siete y media de la tarde. Para inscribirse, hay que completar el formulario antes del treinta de agosto.'
  afconvert -f WAVE -d LEI16@44100 "audio/clear_spanish_4.aiff" "audio/clear_spanish_4.wav"
  rm -f "audio/clear_spanish_4.aiff"
  echo "  [5/5] clear_spanish_5.wav"
  say -v "$VOICE" -r 190 -o "audio/clear_spanish_5.aiff" 'Les recordamos que el desayuno se sirve de siete a diez de la mañana en la primera planta. Los sábados y domingos termina a las once. Para pedir desayuno en la habitación, marque el número cinco.'
  afconvert -f WAVE -d LEI16@44100 "audio/clear_spanish_5.aiff" "audio/clear_spanish_5.wav"
  rm -f "audio/clear_spanish_5.aiff"
  echo "Spanish audio generated."
else
  echo "Spanish audio already exists."
fi

if [ ! -s "audio/clear_spanish_1.wav" ]; then
  osascript -e 'display dialog "Could not create clear_spanish_1.wav. Please check that a Spanish voice is installed in macOS." buttons {"OK"} default button "OK"'
  exit 1
fi
if [ ! -s "audio/clear_spanish_2.wav" ]; then
  osascript -e 'display dialog "Could not create clear_spanish_2.wav. Please check that a Spanish voice is installed in macOS." buttons {"OK"} default button "OK"'
  exit 1
fi
if [ ! -s "audio/clear_spanish_3.wav" ]; then
  osascript -e 'display dialog "Could not create clear_spanish_3.wav. Please check that a Spanish voice is installed in macOS." buttons {"OK"} default button "OK"'
  exit 1
fi
if [ ! -s "audio/clear_spanish_4.wav" ]; then
  osascript -e 'display dialog "Could not create clear_spanish_4.wav. Please check that a Spanish voice is installed in macOS." buttons {"OK"} default button "OK"'
  exit 1
fi
if [ ! -s "audio/clear_spanish_5.wav" ]; then
  osascript -e 'display dialog "Could not create clear_spanish_5.wav. Please check that a Spanish voice is installed in macOS." buttons {"OK"} default button "OK"'
  exit 1
fi

OLD_PID=$(lsof -ti tcp:$PORT 2>/dev/null || true)
if [ -n "$OLD_PID" ]; then kill $OLD_PID 2>/dev/null || true; sleep 1; fi

echo "Starting app..."
python3 -m http.server "$PORT" >/tmp/dele_fitness_app.log 2>&1 &
SERVER_PID=$!
sleep 1
open "http://localhost:$PORT/index.html?audio=v3"
echo ""
echo "App opened in your browser."
echo "Keep this window open while using it."
echo "Press Control-C when finished."
wait $SERVER_PID