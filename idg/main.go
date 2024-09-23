// Package idg(Integration Document index-Generator) used to generate index page for integrations.
package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/fs"
	"log"
	"os"
	"path/filepath"
	"regexp"
	"strings"
	"text/template"

	"gopkg.in/yaml.v2"
)

var (
	flagPath     = flag.String("integration-path", "", "path of integration docs")
	flagTemplate = flag.String("template", "", "template file path")
	flagOut      = flag.String("out", "", "generated result file")
	flagLang     = flag.String("lang", "zh", "language(zh/en) to generate")
	flagVerison  = flag.Bool("version", false, "show version info")
)

var (
	searchPrompt = map[string]string{
		"zh": "搜索集成",
		"en": "Search",
	}

	Version = "not-set"
	BuildAt = "not-set"
	Commit  = "not-set"

	failedIDoc, okIDoc, skipped []string
)

func init() {
	log.SetFlags(log.LstdFlags | log.Lshortfile)
}

type render struct {
	SearchPrompt string
	IDocs        []*integrationDoc
	NIDocs       int
}

type integrationDoc struct {
	Name,
	Summary,
	Logo,
	HRef,
	Tags string
}

func main() {
	flag.Parse()

	if *flagVerison {
		fmt.Printf(`
version: %s
build:   %s
commit:  %s
`, Version, BuildAt, Commit)
		return
	}

	if err := do(); err != nil {
		os.Exit(-1)
	}

	log.Printf("ok docs(%d)", len(okIDoc))
	for _, x := range okIDoc {
		fmt.Printf("\t%s\n", x)
	}

	log.Printf("skiped docs(%d)", len(skipped))
	for _, x := range skipped {
		fmt.Printf("\t%s\n", x)
	}

	log.Printf("failed docs(%d):", len(failedIDoc))
	for _, x := range failedIDoc {
		fmt.Printf("\t%s\n", x)
	}
}

func do() error {
	var idocs []*integrationDoc

	t := template.New(``)

	tem, err := os.ReadFile(*flagTemplate)
	if err != nil {
		log.Printf("[E] fail to read template %q: %s", *flagTemplate, err.Error())
		return err
	}

	t, err = t.Parse(string(tem))
	if err != nil {
		log.Printf("[E] invalid template %q: %s", *flagTemplate, err.Error())
		return err
	}

	if *flagPath == "" {
		log.Printf("[E] integration path not set")
		return fmt.Errorf("integration path not set")
	}

	filepath.Walk(*flagPath, func(path string, info fs.FileInfo, err error) error {

		log.Printf("[I] on path %q", path)

		if info.IsDir() {
			log.Printf("[I] skip dir %q", path)
			return nil
		}

		if !strings.HasSuffix(info.Name(), ".md") {
			log.Printf("[I] skip non-markdown file %q", path)
			return nil
		}

		if filepath.Base(path) == "integration-index.md" {
			log.Printf("[I] skip %q", path) // do not touch this file
			return nil
		}

		rawmd, err := os.ReadFile(path)
		if err != nil {
			log.Printf("[W] failed to read markdown %q: %s, ignored", path, err.Error())
			failedIDoc = append(failedIDoc, path)
			return nil
		}

		header, err := readHead(rawmd)
		if err != nil {
			log.Printf("[W] failed to read header of %q: %s, ignored", path, err.Error())
			failedIDoc = append(failedIDoc, path)
			return nil
		} else {

			if header.Skip != "" {
				log.Printf("[I] %q skipped, reason: %q", path, header.Skip)
				skipped = append(skipped, path)
				return nil
			}

			if header.Title == "" { // title required
				log.Printf("[W] %q title missing, ignored", path)
				return nil
			}

			idoc, _ := header.toIDoc(path)

			idoc.HRef = filepath.Join("..", strings.TrimSuffix(filepath.Base(path), ".md"))

			log.Printf("[I] add integration %q", path)
			idocs = append(idocs, idoc)
			okIDoc = append(okIDoc, path)
			return nil
		}
	})

	r := &render{
		SearchPrompt: searchPrompt[*flagLang],
		IDocs:        idocs,
		NIDocs:       len(idocs) - len(idocs)%10, // 显示精确的数字显得呆板，对于 256 个集成，此处将显示成「250 多种」
	}
	_ = r

	buf := &bytes.Buffer{}
	if err := t.Execute(buf, r); err != nil {
		log.Printf("[E] failed to rend: %s", err.Error())
		return err
	}

	if err := os.WriteFile(*flagOut, buf.Bytes(), 0600); err != nil {
		log.Printf("[E] failed to output: %s", err.Error())
		return err
	}

	return nil
}

type dashboard struct {
	Desc string `yaml:"desc"`
	Path string `yaml:"path"`
}

type monitor struct {
	Desc string `yaml:"desc"`
	Path string `yaml:"path"`
}

type explorer struct{} // TODO

type mdYaml struct {
	/*
		title      : 'MySQL'
		summary    : '采集 MySQL 的指标数据'
		__int_icon : 'icon/mysql'
		tags       :
		  - aliyun
			- mysql
		dashboard :
		  - desc  : 'MySQL'
		    path  : 'dashboard/zh/mysql'
		monitor   :
		  - desc  : '暂无'
		    path  : 'monitor/zh/mysql'
		explorer  :
		  - desc  : 'MySQL 查看器'
			  path  : 'explorer/zh/mysql'
	*/

	Skip     string   `yaml:"skip"`
	Title    string   `yaml:"title"`
	Summary  string   `yaml:"summary"`
	IconPath string   `yaml:"__int_icon"`
	Tags     []string `yaml:"tags"`

	Dashboard []dashboard `yaml:"dashboard"`
	Monitor   []monitor   `yaml:"monitor"`
	Explorer  []explorer  `yaml:"explorer"`
}

func defaultIntegrationDoc() *integrationDoc {
	return &integrationDoc{}
}

func (h *mdYaml) toIDoc(fpath string) (*integrationDoc, error) {
	idoc := defaultIntegrationDoc()

	if h.Title == "" {
		log.Printf("[W] title not found in file %q, ignored", fpath)
	}

	if strings.ToLower(h.IconPath) != h.IconPath {
		log.Printf("[W] icon path should always lower-case, but got %q, ignored", h.IconPath)
	}

	if len(h.Tags) == 0 {
		log.Printf("[W] got no tags in %q(summary: %q), ignored", h.Title, h.Summary)
	}

	idoc.Name = h.Title
	idoc.Summary = h.Summary
	idoc.Logo = fmt.Sprintf("../%s/icon.png", h.IconPath)
	idoc.Tags = strings.Join(h.Tags, ",")

	return idoc, nil
}

func readHead(raw []byte) (*mdYaml, error) {
	header, err := extractYAML(raw)
	if err != nil {
		return nil, err
	}

	var x mdYaml
	if err := yaml.Unmarshal(header, &x); err != nil {
		log.Printf("[W] get invalid header: %s\n%s", err.Error(), header)

		return nil, fmt.Errorf("invalid yaml header: %w", err)
	}

	return &x, nil
}

var (
	headerYamlRe = regexp.MustCompile(`(?s)---\s*(.+?)\s*---`)
)

func extractYAML(text []byte) ([]byte, error) {
	match := headerYamlRe.FindSubmatch(text)

	if len(match) > 1 {
		return match[1], nil
	}

	return nil, fmt.Errorf("no YAML found")
}
