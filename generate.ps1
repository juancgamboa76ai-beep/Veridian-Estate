$content = Get-Content -Raw "index.html"
$head_match = [regex]::Match($content, '(?s)(<head>.*?</head>)').Groups[1].Value
$new_css = @"
        /* Adicionales para páginas interiores */
        .page-header {
            padding: 12rem 5% 4rem;
            background-color: var(--primary);
            text-align: center;
            color: white;
            position: relative;
        }
        .page-header h1 {
            font-size: 3.5rem;
            color: white;
            margin-bottom: 1rem;
        }
        .page-header h1 span {
            color: var(--accent);
        }
        .page-header p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 300;
        }
</head>
"@
$head_content = $head_match -replace '</head>', $new_css

$nav_match = [regex]::Match($content, '(?s)(<nav>.*?</nav>)').Groups[1].Value
$nav_content = $nav_match -replace 'href="#', 'href="index.html#'
$nav_content = $nav_content -replace 'href="#"', 'href="index.html"'

$footer_match = [regex]::Match($content, '(?s)(<footer>.*?</footer>)').Groups[1].Value
$footer_content = $footer_match

$scripts = '<script src="https://cdn.botpress.cloud/webchat/v3.6/inject.js"></script>' + "`n" + '<script src="https://files.bpcontent.cloud/2026/02/12/02/20260212021549-43G4A9Z1.js" defer></script>'

function Create-Page($filename, $title, $hero_title, $hero_desc, $services_html) {
    if ([string]::IsNullOrWhiteSpace($head_content)) { Write-Host "Head content empty!"; return }
    $title_tag = "<title>$title | Veridian Estate</title>"
    $replaced_head = $head_content -replace '<title>Veridian Estate \| Paisajismo Residencial de Lujo</title>', $title_tag
    
    $page_html = @"
<!DOCTYPE html>
<html lang="es">
$replaced_head
<body>
$nav_content
    <header class="page-header">
        <h1>$hero_title</h1>
        <p>$hero_desc</p>
    </header>
    <section class="services">
        <div class="grid">
$services_html
        </div>
    </section>
$footer_content
$scripts
</body>
</html>
"@
    Set-Content -Path $filename -Value $page_html -Encoding UTF8
}

Create-Page "diseno-curatorial.html" "Diseño Curatorial" "Diseño <span>Curatorial</span>" "Planificación maestra visualizada digitalmente, fusionando sus deseos con nuestra experiencia botánica y arquitectónica." @"
            <div class="card" id="diseno-planificacion">
                <div class="image-container">
                    <img src="Planificacion Maestra.png" alt="Planificación Maestra">
                </div>
                <div class="card-body">
                    <h3>Planificación Maestra</h3>
                    <p>Desarrollo estratégico del espacio asegurando un flujo natural y armonioso.</p>
                </div>
            </div>
            <div class="card" id="diseno-botanico">
                <div class="image-container">
                    <img src="Selección Botanica.png" alt="Selección Botánica">
                </div>
                <div class="card-body">
                    <h3>Selección Botánica</h3>
                    <p>Curaduría meticulosa de especies de acuerdo al clima, suelo y estética deseada.</p>
                </div>
            </div>
            <div class="card" id="diseno-3d">
                <div class="image-container">
                    <img src="modelado_3d.png" alt="Visualización 3D">
                </div>
                <div class="card-body">
                    <h3>Visualización 3D</h3>
                    <p>Renders hiperrealistas y recorridos virtuales que adelantan la experiencia final.</p>
                </div>
            </div>
"@

Create-Page "hardscaping.html" "Hardscaping y Estructuras" "Hardscaping <span>& Estructuras</span>" "Pérgolas, fogones y estructuras en piedra natural y maderas nobles que definen la permanencia del espacio exterior." @"
            <div class="card" id="hard-pergolas">
                <div class="image-container">
                    <img src="Pergola.png" alt="Pérgolas y Cenadores">
                </div>
                <div class="card-body">
                    <h3>Pérgolas y Cenadores</h3>
                    <p>Estructuras de sombra elegantes construidas con maderas nobles y metales premium.</p>
                </div>
            </div>
            <div class="card" id="hard-terrazas">
                <div class="image-container">
                    <img src="terraza.png" alt="Terrazas y Decks">
                </div>
                <div class="card-body">
                    <h3>Terrazas y Decks</h3>
                    <p>Extensiones del hogar que invitan al disfrute al aire libre con acabados impecables.</p>
                </div>
            </div>
            <div class="card" id="hard-fuego">
                <div class="image-container">
                    <img src="fogata.png" alt="Zonas de Fuego y Piedra">
                </div>
                <div class="card-body">
                    <h3>Zonas de Fuego</h3>
                    <p>Fogones esculpidos en piedra natural que se convierten en el centro de reunión nocturna.</p>
                </div>
            </div>
"@

Create-Page "iluminacion.html" "Iluminación Escénica" "Iluminación <span>Escénica</span>" "Transformamos la noche en una experiencia sensorial mediante sistemas de luz cálida estratégica y eficiente." @"
            <div class="card" id="ilu-arquitectonica">
                <div class="image-container">
                    <img src="Iluminacion Arquitectonica.png" alt="Iluminación Arquitectónica">
                </div>
                <div class="card-body">
                    <h3>Ilum. Arquitectónica</h3>
                    <p>Resalte de volúmenes y texturas constructivas para una fachada nocturna imponente.</p>
                </div>
            </div>
            <div class="card" id="ilu-botanica">
                <div class="image-container">
                    <img src="Resalte Botanico.png" alt="Resalte Botánico">
                </div>
                <div class="card-body">
                    <h3>Resalte Botánico</h3>
                    <p>Juego de luces y sombras que magnifican la silueta y textura de las especies vegetales clave.</p>
                </div>
            </div>
            <div class="card" id="ilu-sistemas">
                <div class="image-container">
                    <img src="https://images.unsplash.com/photo-1558002038-1055907df827?auto=format&fit=crop&q=80&w=800" alt="Sistemas Inteligentes">
                </div>
                <div class="card-body">
                    <h3>Sistemas Inteligentes</h3>
                    <p>Control domótico integral para ambientar espacios con un solo toque desde su dispositivo preferido.</p>
                </div>
            </div>
"@
Write-Host "Pages generated successfully!"
